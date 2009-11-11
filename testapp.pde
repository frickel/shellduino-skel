#define BAUD		115200	
#define DELAY		5000
#define RST		2

#define INIT_SEQ	0x55
#define CMD_CLEAR	0x45
#define CMD_BGCOLOR	0x42
#define CMD_CPYPASTE	0x63
#define	CMD_LINE	0x4C
#define CMD_CIRCLE	0x43
#define CMD_FILLCIRCLE	0x69
#define CMD_PUTPIXEL	0x50
#define CMD_READPIXEL	0x52
#define CMD_RECTANGLE	0x72
#define CMD_TRIANGLE	0x47
#define CMD_PAINTAREA	0x70
#define CMD_SETFNTSIZE	0x46
#define FONT_5X7	0x01
#define FONT_8x8	0x02
#define FONT_8x12	0x03
#define CMD_FMTTEXT	0x54
#define CMD_CTL		0x59
#define CMD_DSPL	0x01
#define CMD_CONTRAST	0x02
#define CMD_POWER	0x03
#define RESPONSE_ACK	0x06
#define RESPONSE_NAK	0x15

void displayReset()
{
        digitalWrite(RST, LOW);
        delay(20);
        digitalWrite(RST, HIGH);
        delay(20);
}


char getDisplayResponse()
{
        byte incomingByte = RESPONSE_ACK;

        while(!Serial.available()) { delay(1); }
        incomingByte = Serial.read();
        return incomingByte;
}

void displayInit()
{
	displayReset();
	delay(DELAY);
	Serial.print(INIT_SEQ, BYTE);
	getDisplayResponse();
}

void displayClear()
{
	Serial.print(CMD_CLEAR, BYTE);
	delay(20);
	getDisplayResponse();
}

void displaySetBgColor(int color)
{
	Serial.print(CMD_BGCOLOR, BYTE);
	Serial.print(color >> 8, BYTE);		// MSB
	Serial.print(color & 0xFF, BYTE);	// LSB
}

displaySetFontSize(int size)
{
	Serial.print(CMD_SETFNTSIZE, BYTE);
	Serial.print(size, BYTE);
}

displayDrawCircle(int x, int y, int rad, int color)
{
	Serial.print(CMD_CIRCLE, BYTE);
	Serial.print(x, BYTE);
	Serial.print(y, BYTE);
	Serial.print(rad, BYTE);
	Serial.print(color >> 8, BYTE);		// MSB
	Serial.print(color & 0xFF, BYTE);	// LSB
}

displayDrawTriangle(int x1, int y1, int x2, int y2, int color)
{
	Serial.print(CMD_TRIANGLE, BYTE);
	Serial.print(x1, BYTE);
	Serial.print(y1, BYTE);
	Serial.print(x2, BYTE);
	Serial.print(y2, BYTE);
	Serial.print(color >> 8, BYTE);		// MSB
	Serial.print(color & 0xFF, BYTE);	// LSB
}
}

void displayDrawChar(char col, char row, char size, char myChar, int color)
{
	Serial.print(CMD_FMTTEXT, BYTE);
	Serial.print(myChar, BYTE);
	Serial.print(col, BYTE);
	Serial.print(row, BYTE);
	Serial.print(color >> 8, BYTE);		// MSB
	Serial.print(color & 0xFF, BYTE);	// LSB
	getDisplayResponse();
}

void printByte(byte b)
{
        Serial.print(b, BYTE);
}


void setup()
{
        Serial.begin(BAUD);     // The OLED-Display is connected via UART

        pinMode(RST, OUTPUT);   // The OLED-Display's Reset-Pin is an OUTPUT.

        displayInit();
        displayClear();
        displayDrawChar(1, 1, 10, '4', 52333);
	displayDrawChar(2, 1, 10, '2', 52333);

	delay(2000);
printByte(0x40); //extcmd in hex
printByte(0x49); //cmd in hex
printByte(0); //x
printByte(0); //y
printByte(128); //width 128
printByte(128); //height 128
printByte(16); //colour mode 16
//sector address of photo
printByte(0); //0
printByte(16); //16
printByte(0); //0
}

void loop()
{
        // Do nothing
}

