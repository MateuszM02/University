def count_return_to_origin(commands):
    n = len(commands)
    count = 0
    
    for i in range(n):
        x, y = 0, 0
        for j in range(i, n):
            if commands[j] == 'U':
                y += 1
            elif commands[j] == 'D':
                y -= 1
            elif commands[j] == 'R':
                x += 1
            elif commands[j] == 'L':
                x -= 1
            
            if x == 0 and y == 0:
                count += 1
    
    return count

n = input()
commands = input()
print(count_return_to_origin(commands))