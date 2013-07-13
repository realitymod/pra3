class PRA3_dlg_spawnScreen
{
	idd = -1;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "_this select 0 call PRA3_fnc_onRespawnDlgLoad";
	onUnLoad = "_this select 0 call PRA3_fnc_onRespawnDlgUnload";
	
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
			colorBackground[] = {0,0,0,0.7};
			
			idc = 10;
			x = 0;
			y = 0;
			w = 0.3;
			h = 1;
			onLBSelChanged = "[_this, 'onLBSelChanged'] call PRA3_fnc_respawnDlgAction";
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
