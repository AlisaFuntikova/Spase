import numpy as np



def check_crossroad(robot, point1, point2, point3, point4):
    x_1 = min(point1[0], point2[0], point3[0], point4[0])
    x_2 = max(point1[0], point2[0], point3[0], point4[0])
    y_1 = min(point1[1], point2[1], point3[1], point4[1])
    y_2 = max(point1[1], point2[1], point3[1], point4[1])
    z_1, z_2 = robot
    
    return ((x_1 <= z_1 <= x_2) and (y_1 <= z_2 <= y_2))



def check_collision(coefficients):
    col = []
    k = coefficients.shape[0]
    
    for i in range(k):
        for j in range(k):
            if i != j:
                a1, b1, c1 = coefficients[i]
                a2, b2, c2 = coefficients[j]
                N = np.array([[a1, b1], [a2, b2]])
                V = np.array([-c1, -c2])
                r_N = np.linalg.matrix_rank(N)
                r_NV = np.linalg.matrix_rank(np.column_stack((N, V)))
                
                if r_N == r_NV == 2:
                    col.append((i, j))
                    
    return col



def check_path(points_list):
    dis = 0
    
    for i in range(len(points_list) - 1):
        x1, y1 = points_list[i]
        x2, y2 = points_list[i+1]
        l = np.sqrt( (x2 - x1)**2 + (y2 - y1)**2 )
        dis += l
        
    o = round(dis, 2)
    
    return o
