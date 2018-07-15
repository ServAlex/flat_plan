wallThick = 420;
wallMedium = 200;
wallThin = 100;

leftRoomWidth = (2809+2817)/2;
leftRoomHeight = (6185+6184)/2;
//leftRoomHeight = 1685+500+1800+500+400+1000+300;

middleRoomWidth = (2708+2740)/2;
middleRoomHeight = (4792+4782)/2;

bathroomWidth = 1798;
bathroomHeight = 2485;

coridorWidth_1 = middleRoomWidth+wallThin;
coridorHeight_1 = 1300;

coridorWidth_2 = 1506;
coridorHeight_2 = 2495;

kitchenCoridorWidth = 3398-1621; //771;	// TODO: check this value
kitchenCoridorHeight = 760;

kitchenWidth = 3398;
kitchenHeight = 2823;

bathroomWidth = (1805+1798)/2;
bathroomHeight = 2497;

balconyWidth = 3085;
balconyHeight = 1300;

innerTotalHeight = leftRoomHeight;
innerTotalWidth = leftRoomWidth + wallMedium + middleRoomWidth + wallThin + coridorWidth_2 + wallThin + bathroomWidth;
innerTotalThickness = 2500;

balconyDoorPosition = wallMedium + innerTotalWidth - kitchenWidth + 559;
balconyPosition = balconyDoorPosition - 200;

windowWidth = 1595;			// TODO: check this value;
windowThickness = 1200;		// TODO: check this value;
windowBottomOffset = 800;	// TODO: check this value;
leftWindowOffset = 500;		// TODO: check this value;
middleWindowOffset = 500;	// TODO: check this value;

doorsThickness = 2000;		// TODO: check this value;

leftRoomDoorWidth = 920;	// TODO: check this value;
leftRoomDoorOffset = 286;

middleRoomDoorWidth = 900;	// TODO: check this value;
middleRoomDoorOffset = 200;

bathroomDoorOffset = 899;
bathroomDoorWidth = 900;	// TODO: check this value;

kitchenDoorWidth = 900;		// TODO: check this value;
kitchenDoorOffset = 300;

balconyDoorWidth = 800;		// TODO: check this value;
balconyWindowWidth = 790;	// TODO: check this value;
balconyFenceHeight = 700;

entrenceDoorWidth = 1000;	// TODO: check this value;
entrenceDoorBathroomOffset = 100;	// TODO: check this value;


mode = "all";
//mode = "crossection";

if(mode == "all")
	all_the_walls();
else if(mode == "crossection")
{
	balconyFenceHeight = 900;
	translate([0, 0, -windowBottomOffset -100])
	crossection();
}

module crossection()
{
	difference()
	{
		all_the_walls();

		translate([-10, -10, -50])
		cube([100000, 100000, windowBottomOffset + 100]);
		translate([-10, -10, windowBottomOffset + 100])
		cube([100000, 100000, 10000]);
	}
}

module all_the_walls()
{
	difference()
	{
		union()
		{
			// main body
			cube([wallMedium + innerTotalWidth+wallMedium, wallThick + innerTotalHeight + wallMedium, innerTotalThickness]);

			// balcony
			// TODO: check if balcony walls are this thick
			translate([balconyPosition - wallThin, wallMedium + innerTotalHeight + wallThick, 0])
			cube([balconyWidth + wallThin*2, balconyHeight + wallThin, balconyFenceHeight]);
		}

		// cavities
		union()
		{
			// left room
			translate([wallMedium, wallMedium, -1])
			cube([leftRoomWidth, leftRoomHeight, innerTotalThickness+2]);

			// coridor in 2 parts
			// leading to left room
			translate([wallMedium + leftRoomWidth + wallMedium, wallMedium, -1])
			cube([coridorWidth_1+1, coridorHeight_1, innerTotalThickness+2]);

			// leading to kitchen
			translate([wallMedium + leftRoomWidth + wallMedium + coridorWidth_1, wallMedium, -1])
			cube([coridorWidth_2, coridorHeight_2, innerTotalThickness+2]);

			// bathroom
			translate([wallMedium + leftRoomWidth + wallMedium + coridorWidth_1 + coridorWidth_2 + wallThin, wallMedium, -1])
			cube([bathroomWidth, bathroomHeight, innerTotalThickness+2]);

			// middle room
			translate([wallMedium + leftRoomWidth + wallMedium, wallMedium + coridorHeight_1 + wallThin, -1])
			cube([middleRoomWidth, middleRoomHeight, innerTotalThickness+2]);

			// kitchen: entrence part
			translate([wallMedium + leftRoomWidth + wallMedium + coridorWidth_1, wallMedium + coridorHeight_2 + wallThin, -1])
			cube([kitchenCoridorWidth, kitchenCoridorHeight + 1, innerTotalThickness+2]);

			// kitchen: main part
			translate([wallMedium + leftRoomWidth + wallMedium + coridorWidth_1, wallMedium + coridorHeight_2 + wallThin + kitchenCoridorHeight, -1])
			cube([kitchenWidth, kitchenHeight, innerTotalThickness+2]);

			// balcony
			translate([balconyPosition, wallMedium + innerTotalHeight + wallThick - 1, -1])
			cube([balconyWidth, balconyHeight, innerTotalThickness+2]);

			// windows and doorways
			// left room door
			translate([wallMedium + leftRoomWidth - 1, wallMedium + leftRoomDoorOffset, -1])
			cube([wallMedium + 2, leftRoomDoorWidth, doorsThickness + 1]);
			// window
			translate([wallMedium + leftWindowOffset, wallMedium + leftRoomHeight - 1, windowBottomOffset])
			cube([windowWidth, wallThick+2, windowThickness]);

			// middle room door
			translate([wallMedium + leftRoomWidth + wallMedium + middleRoomWidth - middleRoomDoorWidth - middleRoomDoorOffset, wallMedium + coridorHeight_1 - 1, -1])
			cube([middleRoomDoorWidth, wallThin + 2, doorsThickness + 1]);
			// window
			translate([wallMedium + leftRoomWidth + wallMedium + middleWindowOffset, wallMedium + leftRoomHeight - 1, windowBottomOffset])
			cube([windowWidth, wallThick+2, windowThickness]);

			// kitchen door
			translate([wallMedium + leftRoomWidth + wallMedium + coridorWidth_1 + kitchenDoorOffset, wallMedium + coridorHeight_2 - 1, -1])
			cube([kitchenDoorWidth, wallThin + 2, doorsThickness + 1]);

			// entrence door
			translate([wallMedium + leftRoomWidth + wallMedium + coridorWidth_1 + coridorWidth_2 - entrenceDoorWidth - entrenceDoorBathroomOffset, -1, -1])
			cube([entrenceDoorWidth, wallMedium + 2, doorsThickness + 1]);

			// bathroom door
			translate([wallMedium + leftRoomWidth + wallMedium + coridorWidth_1 + coridorWidth_2 -1, wallMedium + bathroomDoorOffset, -1])
			cube([wallThin + 2, bathroomDoorWidth, doorsThickness + 1]);

			// balcony door
			translate([balconyDoorPosition, wallMedium + leftRoomHeight -7, -1])	// TODO: check placement and size, wher did we get 7mm offset? wrong kitchen placement?
			cube([balconyDoorWidth, wallThick+2+7, doorsThickness + 1]);
			// window
			translate([balconyDoorPosition+balconyDoorWidth-1, wallMedium + leftRoomHeight -7, windowBottomOffset])	// TODO: check placement and size, wher did we get 7mm offset? wrong kitchen placement?
			cube([balconyWindowWidth+1, wallThick+2+7, windowThickness]);
		}
	}
}
