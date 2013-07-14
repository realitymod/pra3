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
			colorBackground[] = {0.1,0.1,0.1,0.8};
			
			x = 0;
			y = 0;
			w = 1;
			h = 1;
		};
	};
	class Controls
	{
		class CloseDialog : RscShortcutButton
		{
			idc = -1;
			x = safeZoneX + 1.5 - (0.06 / (4/3));
            y = safeZoneY + 0.215;
            w = __EVAL(0.05 / (4/3));
            h = 0.05;
			
			animTextureNormal   = "pra3\pra3_squadsys\dlg\img\exitButton_88.paa";
			animTextureDefault  = "pra3\pra3_squadsys\dlg\img\exitButton_88.paa";
			animTextureDisabled = "pra3\pra3_squadsys\dlg\img\exitButton_88.paa";
			animTextureOver     = "pra3\pra3_squadsys\dlg\img\exitButtonOver_ca.paa";
			animTextureFocused  = "pra3\pra3_squadsys\dlg\img\exitButton_88.paa";
			animTexturePressed  = "pra3\pra3_squadsys\dlg\img\exitButtonOver_ca.paa";
			period = 1;
			periodFocus = 1;
			periodOver = 1;
			
			colorBackground[] = {1,1,1,1};
			
			text = "";
			toolTip = "Close"; 
			action = "CloseDialog 0";
			
			class HitZone
			{
					left = 0;
					top = 0;
					right = 0;
					bottom = 0;
			};
			class TextPos
			{
					left = 0.0;
					top = 0.0;
					right = 0.0;
					bottom = 0.0;
			};
		};
		class Spawns : RscListBox
		{
			colorBackground[] = {0.1,0.1,0.1,0.8};
			
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
