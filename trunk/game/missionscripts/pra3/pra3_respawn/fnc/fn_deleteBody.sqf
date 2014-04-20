#include "scriptDefines.sqh"

diag_log [__FILE__, "Before", isNull _this, _this];
deleteVehicle _this;
diag_log [__FILE__, "After:", isNull _this, _this];
