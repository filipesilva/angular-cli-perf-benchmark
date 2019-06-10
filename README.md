# Angular CLI performance benchmark

This repository contains performance benchmarks for a few open source Angular CLI projects.

It is used to track the performance of the Angular CLI build system across versions to find regressions.

The current benchmarks can be seen on CircleCI: [![CircleCI](https://circleci.com/gh/filipesilva/angular-cli-perf-benchmark.svg?style=svg)](https://circleci.com/gh/filipesilva/angular-cli-perf-benchmark)


## Benchmark package

We have a private [benchmarking package](https://github.com/angular/angular-cli/tree/master/packages/angular_devkit/benchmark) for the CLI repository. 

A build is included here as `angular-devkit-benchmark-<some-version>.tgz` but you can also build it from source.

To install it, clone the CLI repo, then run follow these commands:
```
yarn
yarn build
npm pack dist/@angular-devkit/benchmark
npm install -g angular-devkit-benchmark-0.800.0-beta.18.tgz
```

The filename on the last command might change, depending on the version of the CLI you clone.

To use it, run `benchmark -- command`. The command will depend on the project you use. To benchmark a prod build, do `benchmark -- ng build --prod`.

You can also do `benchmark --iterations 20 -- ng build --prod` to get a larger sample size (20 instead of 5).


## Methodology

The `./benchmark.project.sh` script contains logic to install and benchmark a project. It's used in the CircleCI configuration to run each project through CI.

For instance, to benchmark a new project, run `./benchmark-project.sh https://github.com/filipesilva/cli-eight-project 02cfbec npm`.

To get the base version first update a project to version 8 following https://update.angular.io/. Thats the base variant and should be in the pulled repository SHA.

The "CLI version 8 with differential loading" is obtained by installing `@angular-devkit/build-angular@0.802.0` and `@angular/cli@8.0.2` and then running the benchmark.

Replacing `target` in `./tsconfig.json` from `es2015` to `es5` makes the "CLI version 8 without differential loading" variant.

The "CLI version 7" variant is obtained by by installing `@angular-devkit/build-angular@0.13.9` and `@angular/cli@7.3.9`.

This gives us the base benchmark suite containing:
- CLI version 8 with differential loading
- CLI version 8 without differential loading
- CLI version 7

This suite is run through node 10 and node 12.


## Results

After gathering new benchmark information, it can be recorded here and commented out from the CircleCI job list. 

These results should be updated when either the setup or the project SHA change.

Projects yet to add:
- https://github.com/SAP/cloud-commerce-spartacus-storefront
- https://github.com/vmware/clarity
- https://github.com/aviabird/angularspree (not yet updated to 8, and requires a lot of work to update)


### cli-eight-project

New project created by `ng new`.

<details><summary>Node 12.4.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 21760.00 ms (30060.00, 19530.00, 19730.00, 19830.00, 19650.00)
[benchmark]   Average Process usage: 1.29 process(es) (2.46, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 182.18 % (195.21, 179.67, 178.58, 178.04, 179.42)
[benchmark]   Peak CPU usage: 414.00 % (520.00, 350.00, 370.00, 480.00, 350.00)
[benchmark]   Average Memory usage: 590.44 MB (744.08, 551.52, 559.77, 531.72, 565.12)
[benchmark]   Peak Memory usage: 1139.92 MB (1191.49, 1154.62, 1196.79, 986.98, 1169.75)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 13452.00 ms (15040.00, 14830.00, 12730.00, 12330.00, 12330.00)
[benchmark]   Average Process usage: 1.10 process(es) (1.48, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.60 process(es) (4.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 178.19 % (193.38, 171.08, 175.63, 175.33, 175.53)
[benchmark]   Peak CPU usage: 444.00 % (420.00, 410.00, 490.00, 430.00, 470.00)
[benchmark]   Average Memory usage: 391.04 MB (461.93, 383.10, 361.04, 376.34, 372.79)
[benchmark]   Peak Memory usage: 946.90 MB (933.73, 947.05, 942.14, 989.29, 922.26)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 14078.00 ms (20480.00, 14540.00, 12830.00, 11420.00, 11120.00)
[benchmark]   Average Process usage: 1.28 process(es) (2.38, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 173.17 % (177.22, 164.19, 171.78, 176.55, 176.10)
[benchmark]   Peak CPU usage: 360.00 % (430.00, 320.00, 380.00, 340.00, 330.00)
[benchmark]   Average Memory usage: 392.06 MB (576.98, 348.03, 345.16, 341.52, 348.61)
[benchmark]   Peak Memory usage: 908.22 MB (1063.15, 879.80, 860.92, 871.99, 865.27)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 25530.00 ms (34870.00, 24050.00, 21440.00, 23450.00, 23840.00)
[benchmark]   Average Process usage: 1.29 process(es) (2.47, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 184.34 % (197.62, 179.17, 181.48, 180.97, 182.43)
[benchmark]   Peak CPU usage: 500.22 % (533.33, 511.11, 500.00, 490.00, 466.67)
[benchmark]   Average Memory usage: 510.76 MB (674.68, 463.29, 472.84, 487.71, 455.30)
[benchmark]   Peak Memory usage: 1030.30 MB (1088.06, 996.43, 1012.20, 1055.23, 999.57)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 14972.00 ms (16540.00, 14130.00, 14940.00, 14520.00, 14730.00)
[benchmark]   Average Process usage: 1.08 process(es) (1.42, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.60 process(es) (4.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 178.34 % (190.38, 175.70, 176.70, 175.02, 173.90)
[benchmark]   Peak CPU usage: 458.00 % (450.00, 430.00, 460.00, 490.00, 460.00)
[benchmark]   Average Memory usage: 368.96 MB (426.35, 353.38, 365.57, 354.46, 345.05)
[benchmark]   Peak Memory usage: 906.37 MB (931.14, 880.00, 937.02, 893.53, 890.17)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 15852.00 ms (21750.00, 14930.00, 15320.00, 13930.00, 13330.00)
[benchmark]   Average Process usage: 1.25 process(es) (2.25, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 173.49 % (181.01, 168.80, 169.67, 173.82, 174.14)
[benchmark]   Peak CPU usage: 502.00 % (700.00, 450.00, 470.00, 400.00, 490.00)
[benchmark]   Average Memory usage: 361.75 MB (495.78, 334.88, 327.84, 324.83, 325.43)
[benchmark]   Peak Memory usage: 839.92 MB (909.26, 824.16, 806.54, 821.72, 837.93)
```
</details>


### super-productivity

From https://github.com/johannesjo/super-productivity  

<details><summary>Node 12.4.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 161212.00 ms (248480.00, 146940.00, 128300.00, 138220.00, 144120.00)
[benchmark]   Average Process usage: 1.33 process(es) (2.65, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 164.58 % (165.05, 162.88, 165.41, 163.82, 165.75)
[benchmark]   Peak CPU usage: 588.00 % (900.00, 500.00, 500.00, 520.00, 520.00)
[benchmark]   Average Memory usage: 1672.99 MB (2009.92, 1610.42, 1585.67, 1594.23, 1564.71)
[benchmark]   Peak Memory usage: 2444.32 MB (3131.24, 2230.69, 2257.99, 2276.03, 2325.67)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 69132.00 ms (69420.00, 67120.00, 70110.00, 67710.00, 71300.00)
[benchmark]   Average Process usage: 1.03 process(es) (1.13, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.60 process(es) (4.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 163.18 % (166.67, 161.57, 160.68, 163.18, 163.81)
[benchmark]   Peak CPU usage: 517.33 % (520.00, 566.67, 490.00, 510.00, 500.00)
[benchmark]   Average Memory usage: 1339.96 MB (1452.23, 1315.22, 1291.60, 1319.85, 1320.88)
[benchmark]   Peak Memory usage: 2168.81 MB (2289.33, 2126.45, 2101.01, 2155.27, 2172.00)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 68412.00 ms (112680.00, 58400.00, 57000.00, 57080.00, 56900.00)
[benchmark]   Average Process usage: 1.36 process(es) (2.81, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 164.33 % (164.97, 164.84, 161.21, 165.18, 165.43)
[benchmark]   Peak CPU usage: 540.00 % (690.00, 500.00, 500.00, 500.00, 510.00)
[benchmark]   Average Memory usage: 1376.38 MB (1865.59, 1240.44, 1252.33, 1251.08, 1272.46)
[benchmark]   Peak Memory usage: 2254.31 MB (2886.81, 2090.15, 1930.78, 2132.14, 2231.68)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 203022.00 ms (320720.00, 185220.00, 170860.00, 155420.00, 182890.00)
[benchmark]   Average Process usage: 1.35 process(es) (2.75, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 164.51 % (154.16, 163.92, 168.56, 171.13, 164.77)
[benchmark]   Peak CPU usage: 557.11 % (650.00, 555.56, 520.00, 520.00, 540.00)
[benchmark]   Average Memory usage: 1333.09 MB (1709.25, 1234.43, 1236.67, 1225.88, 1259.21)
[benchmark]   Peak Memory usage: 2019.59 MB (2671.33, 1807.51, 1857.44, 1883.19, 1878.46)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 87418.00 ms (91750.00, 94150.00, 92950.00, 77520.00, 80720.00)
[benchmark]   Average Process usage: 1.03 process(es) (1.13, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.60 process(es) (4.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 160.13 % (162.86, 155.83, 158.79, 161.31, 161.87)
[benchmark]   Peak CPU usage: 546.89 % (650.00, 544.44, 520.00, 510.00, 510.00)
[benchmark]   Average Memory usage: 1032.07 MB (1048.05, 1040.10, 1004.07, 999.71, 1068.42)
[benchmark]   Peak Memory usage: 1659.71 MB (1813.00, 1615.65, 1684.55, 1571.28, 1614.09)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 89746.00 ms (145060.00, 78430.00, 77020.00, 77210.00, 71010.00)
[benchmark]   Average Process usage: 1.36 process(es) (2.81, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 156.10 % (152.71, 155.33, 157.43, 156.50, 158.52)
[benchmark]   Peak CPU usage: 548.44 % (680.00, 522.22, 520.00, 520.00, 500.00)
[benchmark]   Average Memory usage: 1086.97 MB (1592.65, 963.42, 960.56, 971.31, 946.89)
[benchmark]   Peak Memory usage: 1702.50 MB (2539.70, 1438.24, 1606.59, 1474.61, 1453.35)
```
</details>


### awesome-angular-workshop

From https://github.com/johnpapa/awesome-angular-workshop/tree/v8

<details><summary>Node 12.4.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 215834.00 ms (264800.00, 215870.00, 213920.00, 198490.00, 186090.00)
[benchmark]   Average Process usage: 1.22 process(es) (2.10, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 158.76 % (159.77, 156.77, 155.31, 160.48, 161.46)
[benchmark]   Peak CPU usage: 551.11 % (680.00, 500.00, 533.33, 522.22, 520.00)
[benchmark]   Average Memory usage: 1507.06 MB (1607.07, 1455.55, 1510.13, 1454.90, 1507.67)
[benchmark]   Peak Memory usage: 2282.36 MB (2554.88, 2133.67, 2207.41, 2241.69, 2274.16)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 93062.00 ms (110550.00, 87050.00, 87040.00, 85030.00, 95640.00)
[benchmark]   Average Process usage: 1.23 process(es) (2.16, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 164.29 % (167.39, 165.45, 165.47, 162.23, 160.90)
[benchmark]   Peak CPU usage: 573.33 % (844.44, 490.00, 510.00, 500.00, 522.22)
[benchmark]   Average Memory usage: 1347.04 MB (1509.71, 1291.66, 1314.27, 1305.49, 1314.10)
[benchmark]   Peak Memory usage: 2160.64 MB (2580.74, 2046.57, 2050.35, 2032.45, 2093.08)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 53156.00 ms (64120.00, 47490.00, 50290.00, 52090.00, 51790.00)
[benchmark]   Average Process usage: 1.34 process(es) (2.70, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 169.01 % (174.37, 170.94, 168.18, 164.94, 166.59)
[benchmark]   Peak CPU usage: 554.00 % (860.00, 480.00, 480.00, 480.00, 470.00)
[benchmark]   Average Memory usage: 955.26 MB (1223.15, 904.12, 893.83, 877.39, 877.83)
[benchmark]   Peak Memory usage: 1916.12 MB (2515.05, 1741.12, 1771.47, 1750.21, 1802.74)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 209502.00 ms (236860.00, 196810.00, 200980.00, 197700.00, 215160.00)
[benchmark]   Average Process usage: 1.22 process(es) (2.07, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.60 process(es) (8.00, 1.00, 1.00, 2.00, 1.00)
[benchmark]   Average CPU usage: 178.04 % (182.99, 176.13, 180.18, 178.46, 172.47)
[benchmark]   Peak CPU usage: 701.11 % (1316.67, 555.56, 544.44, 533.33, 555.56)
[benchmark]   Average Memory usage: 1229.03 MB (1337.53, 1215.50, 1160.91, 1221.64, 1209.58)
[benchmark]   Peak Memory usage: 1823.30 MB (2302.79, 1797.55, 1645.40, 1697.55, 1673.20)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 114810.00 ms (143480.00, 105190.00, 105660.00, 108410.00, 111310.00)
[benchmark]   Average Process usage: 1.18 process(es) (1.88, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 172.31 % (170.84, 173.34, 175.02, 172.23, 170.10)
[benchmark]   Peak CPU usage: 622.00 % (910.00, 533.33, 555.56, 555.56, 555.56)
[benchmark]   Average Memory usage: 1090.25 MB (1192.52, 1068.54, 1077.91, 1055.49, 1056.81)
[benchmark]   Peak Memory usage: 1739.53 MB (2171.43, 1671.00, 1599.44, 1590.65, 1665.14)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 60292.00 ms (75120.00, 56080.00, 59490.00, 53690.00, 57080.00)
[benchmark]   Average Process usage: 1.32 process(es) (2.60, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 168.80 % (174.17, 166.86, 165.20, 170.58, 167.23)
[benchmark]   Peak CPU usage: 655.56 % (877.78, 640.00, 610.00, 500.00, 650.00)
[benchmark]   Average Memory usage: 762.92 MB (975.47, 711.72, 689.21, 694.61, 743.62)
[benchmark]   Peak Memory usage: 1558.58 MB (2089.78, 1421.06, 1381.95, 1376.15, 1523.96)
```
</details>


### aio

From https://github.com/angular/angular/tree/master/aio.

<details><summary>Node 12.4.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 67188.00 ms (93540.00, 61410.00, 60610.00, 61700.00, 58680.00)
[benchmark]   Average Process usage: 2.00 process(es) (6.01, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 4.00 process(es) (16.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 170.78 % (192.22, 165.58, 165.72, 164.31, 166.09)
[benchmark]   Peak CPU usage: 576.00 % (920.00, 490.00, 510.00, 480.00, 480.00)
[benchmark]   Average Memory usage: 1013.02 MB (1329.66, 920.73, 955.32, 899.21, 960.18)
[benchmark]   Peak Memory usage: 1814.88 MB (2898.75, 1484.76, 1605.84, 1493.54, 1591.52)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 37668.00 ms (46180.00, 33160.00, 31960.00, 37570.00, 39470.00)
[benchmark]   Average Process usage: 1.53 process(es) (3.64, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.60 process(es) (9.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 172.69 % (190.33, 169.14, 169.38, 167.91, 166.68)
[benchmark]   Peak CPU usage: 542.00 % (800.00, 470.00, 500.00, 460.00, 480.00)
[benchmark]   Average Memory usage: 744.41 MB (921.50, 699.36, 685.00, 701.79, 714.41)
[benchmark]   Peak Memory usage: 1551.55 MB (1892.86, 1464.95, 1462.58, 1457.82, 1479.54)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 30662.00 ms (41600.00, 26050.00, 27450.00, 30360.00, 27850.00)
[benchmark]   Average Process usage: 1.93 process(es) (5.65, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 3.60 process(es) (14.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 165.27 % (172.08, 164.32, 164.24, 162.00, 163.69)
[benchmark]   Peak CPU usage: 463.11 % (470.00, 470.00, 455.56, 480.00, 440.00)
[benchmark]   Average Memory usage: 749.66 MB (1134.57, 668.51, 635.41, 674.54, 635.26)
[benchmark]   Peak Memory usage: 1559.87 MB (2243.94, 1388.45, 1331.79, 1472.00, 1363.19)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 75902.00 ms (98400.00, 67710.00, 74540.00, 75450.00, 63410.00)
[benchmark]   Average Process usage: 2.07 process(es) (6.34, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 4.00 process(es) (16.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 174.35 % (195.46, 171.01, 166.88, 166.48, 171.93)
[benchmark]   Peak CPU usage: 598.00 % (960.00, 510.00, 520.00, 490.00, 510.00)
[benchmark]   Average Memory usage: 879.77 MB (1232.57, 789.49, 808.39, 782.46, 785.94)
[benchmark]   Peak Memory usage: 1646.09 MB (2323.54, 1490.85, 1535.31, 1403.29, 1477.43)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 41084.00 ms (48170.00, 35040.00, 40270.00, 40970.00, 40970.00)
[benchmark]   Average Process usage: 1.49 process(es) (3.45, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.60 process(es) (9.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 173.33 % (188.38, 173.52, 167.99, 167.72, 169.03)
[benchmark]   Peak CPU usage: 571.56 % (866.67, 490.00, 511.11, 500.00, 490.00)
[benchmark]   Average Memory usage: 676.58 MB (925.45, 626.83, 620.72, 615.95, 593.96)
[benchmark]   Peak Memory usage: 1343.91 MB (1899.36, 1329.31, 1157.89, 1238.77, 1094.24)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 37114.00 ms (45870.00, 33450.00, 32450.00, 37350.00, 36450.00)
[benchmark]   Average Process usage: 1.91 process(es) (5.56, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 3.60 process(es) (14.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 165.12 % (174.49, 163.10, 164.54, 161.02, 162.47)
[benchmark]   Peak CPU usage: 528.00 % (690.00, 510.00, 470.00, 500.00, 470.00)
[benchmark]   Average Memory usage: 634.71 MB (993.48, 538.10, 555.92, 533.22, 552.81)
[benchmark]   Peak Memory usage: 1348.80 MB (2114.51, 1143.82, 1155.35, 1153.84, 1176.48)
```
</details>

