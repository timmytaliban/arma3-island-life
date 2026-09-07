class CfgPatches
{
	class islandlife_client
	{
		author="Timmy Taliban";
		units[]={};
		weapons[]={};
		requiredVersion=0.1;
		requiredAddons[]={};
	};
};
class CfgFunctions
{
	class credits
	{
		class CREDITS_fnc
		{
			file="\islandlife_client\functions\credits";
			class bootCredits
			{
				preInit=0;
				postInit=1;
				ext=".sqf";
				preStart=0;
				recompile=0;
			};
		};
	};
};