#define ST_POS					0x0F
#define ST_HPOS					0x03
#define ST_VPOS					0x0C
#define ST_LEFT					0x00
#define ST_RIGHT				0x01
#define ST_CENTER				0x02
#define ST_DOWN					0x04
#define ST_UP					0x08
#define ST_VCENTER				0x0c

#define ST_TYPE					0xF0
#define ST_SINGLE				0
#define ST_MULTI				16
#define ST_TITLE_BAR			32
#define ST_PICTURE				48
#define ST_FRAME				64
#define ST_BACKGROUND			80
#define ST_GROUP_BOX			96
#define ST_GROUP_BOX2			112
#define ST_HUD_BACKGROUND		128
#define ST_TILE_PICTURE			144
#define ST_WITH_RECT			160
#define ST_LINE					176

#define ST_SHADOW				0x100
#define ST_NO_RECT				0x200 // this style works for CT_STATIC in conjunction with ST_MULTI
#define ST_KEEP_ASPECT_RATIO	0x800

#define ST_TITLE				ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR					0x400
#define SL_VERT					0
#define SL_HORZ					0x400

#define SL_TEXTURES				0x10

// Listbox styles
#define LB_TEXTURES				0x10
#define LB_MULTI				0x20

#define FontM					"Zeppelin32"


#define __colorText {0.85, 0.85, 0.85, 1.0} //Replaces {0.4, 0.6745, 0.2784, 1.0}
#define __colorSilverTransp {0.75, 0.75, 0.75, 0.75}

#include "\a3\ui_f\hpp\defineCommonColors.inc"
