
/*
 * A simple 'Hello World' Application.
 * 
 * Pinning:
 * Pin 13  -  LED+ (with a resistor)
 * Pin GND -  LED-
 *
 */

// The Pin the LED is attached to
int ledPin = 13;

// Initialization of outputs
void setup()
{
	pinMode(ledPin, OUTPUT);
}

// The infinite "Main"-Loop
void loop()
{
	digitalWrite(ledPin, HIGH);
	delay(500);
	digitalWrite(ledPin, LOW);
	delay(500);
}
