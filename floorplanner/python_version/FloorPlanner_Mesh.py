# Author: Manqing Mao, Email: manqing.mao@asu.edu

from docplex.cp.model import CpoModel
import docplex.cp.utils_visu as visu
import pandas as pd
#-----------------------------------------------------------------------------
# Initialize the problem data
#-----------------------------------------------------------------------------

# Size of the total area
def floorPlanner(CONFIG, SCHEDULER, RATE, printFlag=0, figFlag=0):
    HEIGHT_REC = 4
    WIDTH_REC = 4
    NUM_RESOURCES = 16

    # Sizes of the hardware resources
    SIZE_HARDWARE = [1 for _ in range(NUM_RESOURCES)]

    RESOUCE_dict = {0:'A72', 1:'A53-0', 2:'A53-1', 3:'FFT', 4:'DAP-0', 5:'DAP-1', 6:'Memory', 7:'Cache-1', 8:'Cache-2', 9:'Cache-3', 10:'Cache-4'}

    # read from rpt file
    df = pd.read_fwf("inputs/"+CONFIG+"/trace_"+SCHEDULER+"_"+RATE+"/matrix_traffic_"+SCHEDULER+"_"+RATE+".rpt")   # read file   --- MODIFY HERE
    df = df.drop(df.columns[df.columns.str.contains('unnamed',case = False)],axis = 1)   # drop unnamed
    df = df.drop(range(10))   # drop the first 10 lines
    vol = df.values.tolist()
    vol_commu = [list(map(int,i)) for i in vol]


    extend_factor = NUM_RESOURCES - len(vol_commu)
    for i in range(extend_factor):
        RESOUCE_dict[len(vol_commu)+i] = 'empty'
        
    for _ in range(extend_factor):
        for row in range(len(vol_commu)):
            vol_commu[row].extend([0])
    for _ in range(extend_factor):    
        vol_commu.append([0 for _ in range(len(vol_commu[0]))])

    #-----------------------------------------------------------------------------
    # Build the model
    #-----------------------------------------------------------------------------

    # Create model
    mdl = CpoModel()

    # Create array of variables for subsquares
    vx = [mdl.interval_var(size=SIZE_HARDWARE[i], name="X" + str(i), end=(0, WIDTH_REC)) for i in range(NUM_RESOURCES)]
    vy = [mdl.interval_var(size=SIZE_HARDWARE[i], name="Y" + str(i), end=(0, HEIGHT_REC)) for i in range(NUM_RESOURCES)]

    # Create dependencies between variables
    for i in range(len(SIZE_HARDWARE)):
        for j in range(i):
            mdl.add(  (mdl.end_of(vx[i]) <= mdl.start_of(vx[j])) | (mdl.end_of(vx[j]) <= mdl.start_of(vx[i]))
                    | (mdl.end_of(vy[i]) <= mdl.start_of(vy[j])) | (mdl.end_of(vy[j]) <= mdl.start_of(vy[i])))

    # Set up the objective
    """
    obj = mdl.minimize( mdl.sum( vol_commu[i][j] * ( mdl.max( [mdl.end_of(vx[i]) - mdl.end_of(vx[j]), mdl.end_of(vx[j]) - mdl.end_of(vx[i])] )\
                                                     + mdl.max( [mdl.start_of(vy[i]) - mdl.end_of(vy[j]), mdl.start_of(vy[j]) - mdl.end_of(vy[i])] ) ) \
                                 for i in range(NUM_RESOURCES) for j in range(NUM_RESOURCES) if vol_commu[i][j]) )
    """
    obj = mdl.minimize( mdl.sum( vol_commu[i][j] * ( mdl.max( [mdl.end_of(vx[i]) - mdl.end_of(vx[j]), mdl.end_of(vx[j]) - mdl.end_of(vx[i])] )\
                                                     + mdl.min([mdl.min([mdl.max( [mdl.start_of(vy[i]) - mdl.end_of(vy[j]), 0] ), mdl.max( [mdl.start_of(vy[j]) - mdl.end_of(vy[i]), 0] )]), 1]) ) \
                                 for i in range(NUM_RESOURCES) for j in range(NUM_RESOURCES) if vol_commu[i][j]) )

    mdl.add(obj)

    # To speed-up the search, create cumulative expressions on each dimension
    rx = mdl.sum([mdl.pulse(vx[i], SIZE_HARDWARE[i]) for i in range(NUM_RESOURCES)])
    mdl.add(mdl.always_in(rx, (0, WIDTH_REC), WIDTH_REC, WIDTH_REC))

    ry = mdl.sum([mdl.pulse(vy[i], SIZE_HARDWARE[i]) for i in range(NUM_RESOURCES)])
    mdl.add(mdl.always_in(ry, (0, HEIGHT_REC), HEIGHT_REC, HEIGHT_REC))

    # Define search phases, also to speed-up the search
    mdl.set_search_phases([mdl.search_phase(vx), mdl.search_phase(vy)])


    #-----------------------------------------------------------------------------
    # Solve the model and display the result
    #-----------------------------------------------------------------------------

    # Solve model
    print("Solving model....")
    msol = mdl.solve(TimeLimit=20, LogPeriod=50000)
    if printFlag:
        print("Solution: ")
        msol.print_solution()

    if msol and visu.is_visu_enabled():
        import matplotlib.pyplot as plt
        import matplotlib.cm as cm
        from matplotlib.patches import Polygon
        import matplotlib.ticker as ticker

        # Plot external square
        if figFlag:
            plt.show()
            print("Plotting squares....")
        fig, ax = plt.subplots()
        plt.plot((0, 0), (0, HEIGHT_REC), (WIDTH_REC, HEIGHT_REC), (WIDTH_REC, 0))
        plt.xlim((0, WIDTH_REC))
        plt.ylim((0, HEIGHT_REC//2))
        for i in range(len(SIZE_HARDWARE)):
            # Display square i
            sx, sy = msol.get_var_solution(vx[i]), msol.get_var_solution(vy[i])
            (sx_st, sx_ed, sy_st, sy_ed) = (sx.get_start(), sx.get_end(), sy.get_start(), sy.get_end())

            # transform
            #sx1, sx2, sy1, sy2 = sx_st, sx_ed, sy_st, sy_ed
            sx1 = sx_st+0.5 if sy_st % 2 else sx_st
            sy1 = sy_st/2
            sx2, sy2 = sx1+0.5, sy1+0.5
            
            poly = Polygon([(sx1, sy1), (sx1, sy2), (sx2, sy2), (sx2, sy1)], fc=cm.Set2(float(i) / len(SIZE_HARDWARE)))
            ax.add_patch(poly)
            # Display identifier of square i at its center
            ax.text(float(sx1 + sx2) / 2, float(sy1 + sy2) / 2, RESOUCE_dict[i], ha='center', va='center')
            ax.xaxis.set_major_locator(ticker.MultipleLocator(0.5))
            ax.yaxis.set_major_locator(ticker.MultipleLocator(0.5))
        plt.margins(0)
        fig.savefig("outputs/MESH/"+CONFIG+"_"+SCHEDULER+"_"+RATE+".png")
        if figFlag:
            plt.show()

if __name__ == '__main__':
    CONFIG_List = {"download":["150","500","1000","9000"], "upload":["50","250","1000","9000"], "equal":["100","500","1000","9000"]} 
    SCHEDULER_List = ["ETF", "MET"]
    for key in CONFIG_List.keys():
        for RATE in CONFIG_List[key]:
            for SCHEDULER in SCHEDULER_List:
                floorPlanner(key, SCHEDULER, RATE)

