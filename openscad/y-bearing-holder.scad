//LM8UU
d=15;
l=24;

//overall
width=28;
length=l+4;
height=d+4;

//M5 screw
d5=5.2;

//
spacing=90;

module holder()
{
	difference(){
		cube([length,width,height]);
		//bearing slot
		translate([-0.5,d/2+4,d/2+4]) rotate([0,90,0]) union() {
			cylinder(r=d/2,h=length+1);
			rotate([0,0,135]) cube([d/2,d/2,length+1]);
			rotate([0,0,180]) translate([0,-5,0]) cube([d/2+1,d/2+10,length+1]);
		}
		//mounting screw hole
		translate([length/2,width-d5,0]) cylinder(r=d5/2,h=height*3,center=true);
		//chamfers
		translate([length/2-8,width-d5+3,-0.1]) rotate([0,0,-30]) mirror([1,0,0]) translate([0,-width,0]) cube([length/2,width*2,height*1.2]);
		translate([length/2+8,width-d5+3,-0.1]) rotate([0,0,30]) translate([0,-width,0]) cube([length/2,width*2,height*1.2]);
	}
	for(i=[0,1]) {
		translate([0.8+(length-1.6)*i,d/2+4,2.5]) cube([(length-l)/2-0.4,8,5],center=true);
	}
}
module _single()
{
	holder();
}

module _double()
{
	difference() {
		for(i=[0,1]) {
			translate([i*spacing,0,0]) holder();
			translate([i*(spacing+length-10),0,0]) union() {
				translate([0,-18,0]) cube([10,18,11.5]);
				translate([5,-18,0]) cylinder(r=5,h=11.5);
			}
		}
		for(j=[0,1]) {
			translate([j*(spacing+length-10),0,0]) for(i=[0,1]) {
				translate([5,i*-18,-0.1]) cylinder(r=3.3/2,h=height);
			}
		}
	}
	difference() {
		translate([7.5,-width+6,0]) cube([length+spacing-15,width-6,2]);
		translate([(length+spacing)/2,-71.5,-0.1]) cylinder(r=71.5,h=3);
	}
	translate([length/2+d5/2,0,0]) difference(){
		cube([spacing-d5,width,height/2]);
		//bearing slot
		translate([-0.5,d/2+4,d/2+4]) rotate([0,90,0]) union() {
			cylinder(r=d/2,h=spacing+1);
			rotate([0,0,135]) cube([d/2,d/2,spacing+1]);
			rotate([0,0,180]) translate([0,-5,0]) cube([d/2+1,d/2+10,spacing+1]);
		}
	}
}

//_single();
_double();

