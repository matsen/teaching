l = [''.join([random.choice('AGCT') for i in xrange(200)]) for j in xrange(6)]

with open('data.fasta', 'w') as f:
    for s in l:
        f.write('>x\n')
        f.write(s+'\n')
