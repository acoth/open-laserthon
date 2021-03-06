$in_lower = 1;
include <common.scad>
include <butt.scad>

$fs=0.75;
$fa=5;


module stockThinning(thin2) {
    rotate([90,0,0]) translate([0,0,-epsilon]) {
        multmatrix([
            [1, 0, -3, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0]])
        polyRoundExtrude([
                [-500,-500,0],
                [-500,500,0],
                [0,500,0],
                [10,hLower-triggerDrop+10,20],
                [-10,hLower-triggerDrop-10,20],
                [12-lw,bottom+5,30],
                [100,bottom,0]],
            thin2,1*(thin2/2-epsilon),1*(-thin2/2-epsilon),fn=10*quality);
    }
   
}

    basePoints = [[200,hLower,2*tw],
                [100,hLower-20,35],
                [150,bottom+handHeight+25,10],
                [150,bottom+handHeight,10],
                [50,bottom+handHeight,10],
                [50,bottom+handHeight+25,10],
                [65,(hLower-triggerDrop+bottom+handHeight+20)/2,10],
                [50,hLower-triggerDrop+5,20],
                [30,hLower-triggerDrop+5,10],
                [25,(hLower-triggerDrop+bottom)/2,200],
                [12,bottom,10],
                [-15,bottom,30],
                [-35,bottom+20,30],
                [triggerX-triggerToButt,bottom+20,10],
                [triggerX-triggerToButt,hLower-10,10],
                [-lw-10,hLower-10,30],
                [-lw,hLower+lw/2,30],
                [200,hUpper+2*lw,2*tw]];
    triggerHolePoints = [[60,hLower-triggerDrop,12.5],
                                 [110,hLower-triggerDrop,12.5],
                                 [110,hLower-triggerTop,12.5],
                                 [60,hLower-triggerTop,12.5]];

module base(to) {
    rotate([90,0,0]) translate([-backExt-rearSightDepth,0,-lw+to])
            polyRoundExtrude( offsetRPoints(to,basePoints) ,2*(lw-to),lw-epsilon-to,lw-epsilon-to,fn=10*quality,convexity=30);
}

module triggerHole(to) {
    rotate([90,0,0]) translate([-backExt-rearSightDepth,0,-lw-epsilon+to]) 
                polyRoundExtrude(offsetRPoints(to,triggerHolePoints),2*(lw+epsilon-to),-lw/2+to,-lw/2+to,fn=10);
}

module triggerBlock() {
    rotate([90,0,0]) translate([-backExt-rearSightDepth,0,-lw-epsilon+tw]) 
                polyRoundExtrude([
                    [42,hLower-triggerDrop-tw,5],
                    [85,hLower-triggerDrop-tw,3],
                    [96,hLower-triggerTop+tw,2],
                    [92,hLower-triggerTop+tw,2],
                    [92,hLower+epsilon,2],
                    [96,hLower+epsilon,0],
                    [96,hLower+tw,tw/2],
                    
                    [42,hLower+tw,tw/2]],
                    2*(lw-tw+epsilon),-tw,-tw,fn=10);                   
}

module triggerBlockHole(){
    rotate([90,0,0]) translate([-backExt-rearSightDepth,0,-5.5-epsilon]) 
        polyRoundExtrude([
                    [58,hLower-triggerTop-epsilon-17,0],
                    [58,hLower-triggerTop+10+2*epsilon,0],
                    [83,hLower-triggerTop+10+2*epsilon,3],
                    [83,hLower-triggerTop-epsilon,1],
                    [87,hLower-triggerTop-epsilon,1],
                    [87,hLower-triggerTop-epsilon-17,0]],
                    11+2*epsilon,0.5,0.5,fn=10);
}

rt = 38;
module trigger() {
    translate([0,0,-5])
    difference(){
        union(){scale([1,1,2])
            polyRoundExtrude([
                [-5,-12,3],
                [0,0,rt],
                [-5,12,2],
                [-5,20,4],
                [2,20,4],
                [6,14,rt],
                [10,0,rt],
                [0.5,-12,3]],
            5,2.49,2.49,fn=10);
        polyRoundExtrude([
                [-5,12,2],
                [-5,20,4],
                [2,20,4],
                [6,14,rt],
                [10,0,rt],
                [4,-8,3],
                [-2.5,-10.5,0],
                [5,0,rt],
                [1,11,2]
                ],
            10,1,1,fn=10);
        }
        translate([-1,16,0]) cylinder(r=1.75,h=100,center=true);
    }
    translate([-1,16,0]){
        cylinder(r=1.25,h=13,center=true);
        unionMirror([0,0,1])translate([0,0,5])cylinder(r1=1.25,r2=2.5,h=1.5);
    }
    translate([5,11.5,-4.5])rotate([0,0,20])polyRoundExtrude( beamChain([
            [-1,0,1],
            [2.5,0,1],
            [3.5,6.5,1],
            [5,6.5,1],
            [6.5,-3,1],
            [8,-3,1],
            [10,5.5,1],
            [10.75,7.5,1]],
        offset1=0.5,offset2=-0.5),
        9,0.4,0.4,fn=10);
}

module triggerSwitch(){
    // Body and connectors
    linear_extrude(height=11,center=true,convexity = 10) {
        square([16,28],center=true);
        square([14,30],center=true);
        translate([7,14])circle(r=1);
        translate([-7,14])circle(r=1);
        translate([7,-14])circle(r=1);
        translate([-7,-14])circle(r=1);
        translate([0,17.5]) square([16,25],center=true);
        translate([7,-5]) square([5,30]);
    }
    // Switch Lever
    linear_extrude(height=8,center=true) {
        translate([-15,-12]) circle(r=2);
        translate([-13,-12]) square([4,4],center=true);
        translate([-8,1])square([4,1],center=true);
        translate([-10.5,-6.5])rotate(-7)square([1,15],center=true);
        translate([-7,3])rotate(180)square([3,18]);
    }
    //mounting holes
    mountHoles = [[-5.5,10.5,0],[5.5,-12.5,0]];
    for (p=mountHoles) translate(p){
        cylinder(r=1.6,h=100,center=true);
        mirror([0,0,1]) translate([0,0,5.5+tw]) cylinder(r=m3nr,h=100);
        translate([0,0,5.5+tw]) cylinder(r=m3nr,h=100,$fn=6);
    }
}


module lower(buttExt) {
translate([-backExt-rearSightDepth+triggerX-triggerToButt,0,(bottom+hLower+10)/2]){
    butt(buttExt);
    
}
    difference(){ union(){ difference(){
        union(){ 
            difference()   { base(0); base(tw);}
            intersection() { 
                base(0); 
                union(){
                    triggerHole(tw); 
                    triggerBlock();  
                    translate([-40,0,-40])cube([50,2*(lw+tw),tw],center=true);
                    }
                }
            translate([-backExt-rearSightDepth+50+lw+2.25,0,bottom+handHeight+lw+1])rotate([90,0,0])barFillet(2,[0,0,lw-tw+epsilon],[0,0,-lw+tw-epsilon]);
            translate([-backExt-rearSightDepth+150-lw-1.25,0,bottom+handHeight+lw+1])rotate([90,0,0])barFillet(2,[0,0,lw-tw+epsilon],[0,0,-lw+tw-epsilon]);
            
        }
        triggerHole(0);
        triggerBlockHole();
        rr=3;
 if (quality>1) difference(){
     translate([-backExt-rearSightDepth+65,0,hLower-triggerDrop+6])cube([28,50,32],center=true);
 minkowski() {
     intersection(){
        difference(){ 
               base(rr-epsilon);
               triggerHole(rr-epsilon);
        }
        translate([-backExt-rearSightDepth+65,0,hLower-triggerDrop+6])cube([28,50,32],center=true);
    }
sphere(r=rr);
}
}
        }
        intersection(){
            base(0);
            union(){
                unionMirror([0,1,0])translate([-backExt-rearSightDepth,lw-tw,0])stockThinning(lw-sw1);
                translate([-backExt-rearSightDepth+triggerX-triggerToButt-20,0,(bottom+hLower+10)/2]) {rotate([90,90,0])channel(-gap-epsilon,120+tw);
                difference(){
                    buttHole(tw,adjLength+52);
                    translate([70,0,0])buttHole(0,adjLength-20);    
                    }
                    }
                }
            }       
    }
    unionMirror([0,1,0])translate([-backExt-rearSightDepth,lw,0])stockThinning(lw-sw1);
        translate([0,0,500])cube(1000,center=true);
        translate([-backExt-rearSightDepth/2+t,0,tw])cube([rearSightDepth-t,2*hw+tw,-2*hLower],center=true);
        mirror([0,0,1])rotate([0,90,0])upperBody(0);
    translate([-backExt-rearSightDepth,0,0])rotate([90,0,0])translate([0,0,-lw-epsilon]) polyRoundExtrude([
            [137-lw-tw,hLower-triggerTop-7,tw],
            [127-lw-tw,hLower-tw,tw],
            [150-lw-tw,hLower-tw,tw]],
        2*(lw+epsilon),-tw/2,-tw/2,fn=10);
    unionMirror([0,1,0])translate([-backExt-rearSightDepth,lw-tw/2,0])rotate([90,0,0]) translate([0,0,-tw/2-epsilon]) polyRoundExtrude([
            [52+lw+tw,bottom+handHeight+lw+tw,tw],
            [149-lw-tw,bottom+handHeight+lw+tw,tw],
            [136-lw-tw,bottom+handHeight+lw+tw+10,70],
            [134-lw-tw,hLower-triggerDrop+2,tw],
            [110,hLower-triggerDrop-lw/2-tw,12.5+lw+tw],
            [61+lw+tw,hLower-triggerDrop-lw/2-tw,tw],
            [61+lw+tw,bottom+handHeight+lw+tw+10,40]],
        tw+2*epsilon,-tw/2,-tw/2,fn=10);
        translate([-backExt-rearSightDepth+triggerX-triggerToButt+chanT,0,(bottom+hLower+10)/2]) rotate([90,90,0]){
            for (sn = [0,1]) translate([0,sn*(47+chanT/2),0]) {
            channel(-gap-2*epsilon-tw,47);
            rotate([0,0,90])translate([0,0,-1.5*tw-gap-3*epsilon])polyRoundExtrude([
                    [chanT+tw/2,cf,cf],
                    [47-tw/2-chanT/2,cf,cf],
                    [47-tw/2-chanT/2,-cf,cf],
                    [chanT+tw/2,-cf,cf]],
                3*tw+2*gap+6*epsilon,-tw/2,-tw/2,fn=10);
            }                        
        }
    translate([-backExt-rearSightDepth+triggerX-triggerToButt,0,(bottom+hLower+10)/2]) buttHole(-gap,adjLength);
    translate([-backExt-rearSightDepth+triggerX-triggerToButt,0,(bottom+hLower+10)/2])rotate([90,90,0]){
        translate([-chanW-chanT/2-tw,8-tw/2,0])rotate([0,0,90])triArray(1,5.5,20-tw,1.5*tw,2*(sw1+epsilon),tw*0.75,-tw*0.75,-tw*0.75);
        mirror([1,0,0])
        translate([-chanW-chanT/2-tw,8-tw/2,0])rotate([0,0,90])triArray(1,4.5,20-tw,1.5*tw,2*(sw1+epsilon),tw*0.75,-tw*0.75,-tw*0.75);
        }    
    }
    translate([-backExt-rearSightDepth+triggerX,0,-triggerDrop+1]) rotate([90,0,180])trigger();      
}

if (is_undef($in_assembly)) difference(){
    lower(0);    
    *translate([0,-500,0])cube(1000,center=true);
}