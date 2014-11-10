#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 * Performs the necessary initialization on the unit after mission start or respawn.
 * Runs on every machine.
 */

var(_unit) = _this;

// Stop the unit from talking nonsense over the radio
_unit setSpeaker "NoVoice";
