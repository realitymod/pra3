class PRA3_AAS_captureNotificationFriendly
{
	title              = "Objective Captured";
	description        = "Objective %1 captured by %2";
	colorIconPicture[] = {0,0,0.5,1};
	iconPicture        = "%3";
	priority           = 4;
	sound              = "sectorCaptured";
};
class PRA3_AAS_neutralizedNotificationFriendly : PRA3_AAS_captureNotificationFriendly
{
	title       = "Objective Neutralized";
	description = "Objective %1 neutralized by %2";
};
class PRA3_AAS_captureNotificationHostile : PRA3_AAS_captureNotificationFriendly
{
	colorIconPicture[] = {0.5,0,0,1};
	sound              = "sectorLost";
};
class PRA3_AAS_neutralizedNotificationHostile : PRA3_AAS_neutralizedNotificationFriendly
{
	colorIconPicture[] = {0.5,0,0,1};
	sound              = "sectorLost";
};
