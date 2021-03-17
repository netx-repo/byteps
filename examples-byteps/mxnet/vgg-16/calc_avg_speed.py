# Read log from filename. Calculate the average speed after warmupx10 iterations.
# Print the total number of iterations.

filename = 'test.txt'
warmup = 8
cnt = 0
sum = 0

with open(filename, 'r') as file:
    for line in file:
        line = line.split()
        for i, word in enumerate(line):
            if word == 'Speed:' :
                cnt += 1
                if cnt>warmup:
                    sum += float(line[i+1])

print("total iters (include warmup):", cnt*10)
print("average speed: ", sum/(cnt-warmup), " samples/sec/gpu.")
