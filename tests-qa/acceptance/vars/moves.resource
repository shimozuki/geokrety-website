*** Settings ***
Documentation     Variables for users definitions

*** Variables ***

@{REQUIRE_COORDINATES}    ${0}    ${3}    ${5}

# DROP
&{MOVE_1}     gkid=1    move_type=0    author=1    waypoint=GC0001      lat=43.60000    lon=7.00000     comment=Hello    app=robotframework    app_ver=3.2.1
&{MOVE_2}     gkid=1    move_type=1    author=1    waypoint=${EMPTY}    lat=${EMPTY}    lon=${EMPTY}    comment=Hello    app=robotframework    app_ver=3.2.1
&{MOVE_3}     gkid=1    move_type=2    author=1    waypoint=${EMPTY}    lat=${EMPTY}    lon=${EMPTY}    comment=Hello    app=robotframework    app_ver=3.2.1
&{MOVE_4}     gkid=1    move_type=3    author=1    waypoint=GC0002      lat=43.70000    lon=7.10000     comment=Hello    app=robotframework    app_ver=3.2.1
&{MOVE_5}     gkid=1    move_type=4    author=1    waypoint=${EMPTY}    lat=${EMPTY}    lon=${EMPTY}    comment=Hello    app=robotframework    app_ver=3.2.1
&{MOVE_6}     gkid=1    move_type=5    author=1    waypoint=GC0003      lat=43.80000    lon=7.20000     comment=Hello    app=robotframework    app_ver=3.2.1
