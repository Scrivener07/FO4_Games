package Shared
{
	public class Input
	{
		private static const Backspace:int = 8;
		private static const Tab:int = 9;
		private static const Enter:int = 13;
		private static const CapsLock:int = 20;
		private static const Escape:int = 27;
		private static const Space:int = 32;
		private static const PageUp:int = 33;
		private static const PageDown:int = 34;
		private static const End:int = 35;
		private static const Home:int = 36;
		private static const Left:int = 37;
		private static const Up:int = 38;
		private static const Right:int = 39;
		private static const Down:int = 40;
		private static const Delete:int = 46;
		private static const Number0:int = 48;
		private static const Number1:int = 49;
		private static const Number2:int = 50;
		private static const Number3:int = 51;
		private static const Number4:int = 52;
		private static const Number5:int = 53;
		private static const Number6:int = 54;
		private static const Number7:int = 55;
		private static const Number8:int = 56;
		private static const Number9:int = 57;
		private static const A:int = 65;
		private static const B:int = 66;
		private static const C:int = 67;
		private static const D:int = 68;
		private static const E:int = 69;
		private static const F:int = 70;
		private static const G:int = 71;
		private static const H:int = 72;
		private static const I:int = 73;
		private static const J:int = 74;
		private static const K:int = 75;
		private static const L:int = 76;
		private static const M:int = 77;
		private static const N:int = 78;
		private static const O:int = 79;
		private static const P:int = 80;
		private static const Q:int = 81;
		private static const R:int = 82;
		private static const S:int = 83;
		private static const T:int = 84;
		private static const U:int = 85;
		private static const V:int = 86;
		private static const W:int = 87;
		private static const X:int = 88;
		private static const Y:int = 89;
		private static const Z:int = 90;
		private static const Super:int = 92;
		private static const NumPad0:int = 96;
		private static const NumPad1:int = 97;
		private static const NumPad2:int = 98;
		private static const NumPad3:int = 99;
		private static const NumPad4:int = 100;
		private static const NumPad5:int = 101;
		private static const NumPad6:int = 102;
		private static const NumPad7:int = 103;
		private static const NumPad8:int = 104;
		private static const NumPad9:int = 105;
		private static const NumPadAsterisk:int = 106;
		private static const NumPadPlus:int = 107;
		private static const NumPadMinus:int = 109;
		private static const NumPadPeriod:int = 110;
		private static const NumPadFowardSlash:int = 111;
		private static const F1:int = 112;
		private static const F2:int = 113;
		private static const F3:int = 114;
		private static const F4:int = 115;
		private static const F5:int = 116;
		private static const F6:int = 117;
		private static const F7:int = 118;
		private static const F8:int = 119;
		private static const F9:int = 120;
		private static const F10:int = 121;
		private static const F11:int = 122;
		private static const NumLock:int = 144;
		private static const ScrLock:int = 145;
		private static const LShift:int = 160;
		private static const RShift:int = 161;
		private static const LCtrl:int = 162;
		private static const RCrtl:int = 163;
		private static const LAlt:int = 164;
		private static const RAlt:int = 165;
		private static const SemiColon:int = 186;
		private static const Equals:int = 187;
		private static const Comma:int = 188;
		private static const Minus:int = 189;
		private static const Period:int = 190;
		private static const ForwardSlash:int = 191;
		private static const LeftBracket:int = 219;
		private static const BackwardSlash01:int = 220;
		private static const RightBracket:int = 221;
		private static const Apostrophe:int = 222;
		private static const BackwardSlash02:int = 226;
		private static const Mouse1:int = 256;
		private static const Mouse2:int = 257;
		private static const Mouse3:int = 258;
		private static const Mouse4:int = 259;
		private static const Mouse5:int = 260;


		public static function KeyCodeToPC(keycode:int) : String
		{
			if (keycode == -1)
			{
				return keycode.toString();
			}
			else if (keycode == Backspace)
			{
				return "Backspace";
			}
			else if (keycode == Tab)
			{
				return "Tab";
			}
			else if (keycode == Enter)
			{
				return "Enter";
			}
			else if (keycode == CapsLock)
			{
				return "Caps Lock";
			}
			else if (keycode == Escape)
			{
				return "Escape";
			}
			else if (keycode == Space)
			{
				return "Space";
			}
			else if (keycode == PageUp)
			{
				return "Page Up";
			}
			else if (keycode == PageDown)
			{
				return "Page Down";
			}
			else if (keycode == End)
			{
				return "End";
			}
			else if (keycode == Home)
			{
				return "Home";
			}
			else if (keycode == Left)
			{
				return "Left";
			}
			else if (keycode == Up)
			{
				return "Up";
			}
			else if (keycode == Right)
			{
				return "Right";
			}
			else if (keycode == Down)
			{
				return "Down";
			}
			else if (keycode == Delete)
			{
				return "Delete";
			}
			else if (keycode == Number0)
			{
				return "0";
			}
			else if (keycode == Number1)
			{
				return "1";
			}
			else if (keycode == Number2)
			{
				return "2";
			}
			else if (keycode == Number3)
			{
				return "3";
			}
			else if (keycode == Number4)
			{
				return "4";
			}
			else if (keycode == Number5)
			{
				return "5";
			}
			else if (keycode == Number6)
			{
				return "6";
			}
			else if (keycode == Number7)
			{
				return "7";
			}
			else if (keycode == Number8)
			{
				return "8";
			}
			else if (keycode == Number9)
			{
				return "9";
			}
			else if (keycode == A)
			{
				return "A";
			}
			else if (keycode == B)
			{
				return "B";
			}
			else if (keycode == C)
			{
				return "C";
			}
			else if (keycode == D)
			{
				return "D";
			}
			else if (keycode == E)
			{
				return "E";
			}
			else if (keycode == F)
			{
				return "F";
			}
			else if (keycode == G)
			{
				return "G";
			}
			else if (keycode == H)
			{
				return "H";
			}
			else if (keycode == I)
			{
				return "I";
			}
			else if (keycode == J)
			{
				return "J";
			}
			else if (keycode == K)
			{
				return "K";
			}
			else if (keycode == L)
			{
				return "L";
			}
			else if (keycode == M)
			{
				return "M";
			}
			else if (keycode == N)
			{
				return "N";
			}
			else if (keycode == O)
			{
				return "O";
			}
			else if (keycode == P)
			{
				return "P";
			}
			else if (keycode == Q)
			{
				return "Q";
			}
			else if (keycode == R)
			{
				return "R";
			}
			else if (keycode == S)
			{
				return "S";
			}
			else if (keycode == T)
			{
				return "T";
			}
			else if (keycode == U)
			{
				return "U";
			}
			else if (keycode == V)
			{
				return "V";
			}
			else if (keycode == W)
			{
				return "W";
			}
			else if (keycode == X)
			{
				return "X";
			}
			else if (keycode == Y)
			{
				return "Y";
			}
			else if (keycode == Z)
			{
				return "Z";
			}
			else if (keycode == Super)
			{
				return "Super";
			}
			else if (keycode == NumPad0)
			{
				return "0";
			}
			else if (keycode == NumPad1)
			{
				return "1";
			}
			else if (keycode == NumPad2)
			{
				return "2";
			}
			else if (keycode == NumPad3)
			{
				return "3";
			}
			else if (keycode == NumPad4)
			{
				return "4";
			}
			else if (keycode == NumPad5)
			{
				return "5";
			}
			else if (keycode == NumPad6)
			{
				return "6";
			}
			else if (keycode == NumPad7)
			{
				return "7";
			}
			else if (keycode == NumPad8)
			{
				return "8";
			}
			else if (keycode == NumPad9)
			{
				return "9";
			}
			else if (keycode == NumPadAsterisk)
			{
				return "*";
			}
			else if (keycode == NumPadPlus)
			{
				return "+";
			}
			else if (keycode == NumPadMinus)
			{
				return "-";
			}
			else if (keycode == NumPadPeriod)
			{
				return ".";
			}
			else if (keycode == NumPadFowardSlash)
			{
				return "/";
			}
			else if (keycode == F1)
			{
				return "F1";
			}
			else if (keycode == F2)
			{
				return "F2";
			}
			else if (keycode == F3)
			{
				return "F3";
			}
			else if (keycode == F4)
			{
				return "F4";
			}
			else if (keycode == F5)
			{
				return "F5";
			}
			else if (keycode == F6)
			{
				return "F6";
			}
			else if (keycode == F7)
			{
				return "F7";
			}
			else if (keycode == F8)
			{
				return "F8";
			}
			else if (keycode == F9)
			{
				return "F9";
			}
			else if (keycode == F10)
			{
				return "F10";
			}
			else if (keycode == F11)
			{
				return "F11";
			}
			else if (keycode == NumLock)
			{
				return "Number Lock";
			}
			else if (keycode == ScrLock)
			{
				return "Screen Lock";
			}
			else if (keycode == LShift)
			{
				return "Left Shift";
			}
			else if (keycode == RShift)
			{
				return "Right Shift";
			}
			else if (keycode == LCtrl)
			{
				return "Left Ctrl";
			}
			else if (keycode == RCrtl)
			{
				return "Right Crtl";
			}
			else if (keycode == LAlt)
			{
				return "Left Alt";
			}
			else if (keycode == RAlt)
			{
				return "Right Alt";
			}
			else if (keycode == SemiColon)
			{
				return ";";
			}
			else if (keycode == Equals)
			{
				return "=";
			}
			else if (keycode == Comma)
			{
				return ",";
			}
			else if (keycode == Minus)
			{
				return "-";
			}
			else if (keycode == Period)
			{
				return ".";
			}
			else if (keycode == ForwardSlash)
			{
				return "/";
			}
			else if (keycode == LeftBracket)
			{
				return "[";
			}
			else if (keycode == BackwardSlash01)
			{
				return "\\";
			}
			else if (keycode == RightBracket)
			{
				return "]";
			}
			else if (keycode == Apostrophe)
			{
				return "'";
			}
			else if (keycode == BackwardSlash02)
			{
				return "\\";
			}
			else if (keycode == Mouse1)
			{
				return "Mouse 1";
			}
			else if (keycode == Mouse2)
			{
				return "Mouse 2";
			}
			else if (keycode == Mouse3)
			{
				return "Mouse 3";
			}
			else if (keycode == Mouse4)
			{
				return "Mouse 4";
			}
			else if (keycode == Mouse5)
			{
				return "Mouse 5";
			}
			else
			{
				return "Unknown";
			}
		}


	}
}
