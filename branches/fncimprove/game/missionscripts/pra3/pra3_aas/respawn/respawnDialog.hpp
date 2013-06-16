class PRA3_dlg_spawnScreen
{
	idd = -1;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "_this select 0 call compile preprocessFile ""pra3\pra3_aas\respawn\onRespawnDialogLoad.sqf""";
	onUnLoad = "_this select 0 call compile preprocessFile ""pra3\pra3_aas\respawn\onRespawnDialogUnload.sqf""";
	
	class ControlsBackground
	{
		class Background : RscBackground
		{
			x = 0;
			y = 0;
			w = 1;
			h = 1;
		};
	};
	class Controls
	{
		class Spawns : RscListBox
		{
			idc = 10;
			x = 0;
			y = 0;
			w = 0.3;
			h = 1;
			onLBDblClick = "PRA3_AAS_selectedSpawn = _this select 0 lbData (_this select 1)";
		//	onLBSelChanged = 
		};
		class Map : RscMapControl
		{
			idc = 20;
			x = 0.3;
			y = 0;
			w = 0.7;
			h = 1;
			maxSatelliteAlpha = 0;
		};
	};
};
