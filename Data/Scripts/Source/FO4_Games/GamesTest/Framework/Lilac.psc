ScriptName GamesTest:Framework:Lilac extends Quest
import Games:Papyrus:Log
import GamesTest:Framework:Library

;/
	Papyrus unit test syntax and test runner.
	Base script for creating and running Lilac unit tests. Must be extended.
	Generally executed by `StartQuest MyUnitTestQuest` from the console.
/;

float last_current_time = -1.0
string current_test_suite = ""
string current_test_case = ""
bool test_case_had_failures = false

bool verbose_logging = false
bool warn_on_long_duration = false
float warning_threshold = 0.0

int testsRun = 0
int testsPassed = 0
int testsFailed = 0


; Events
;---------------------------------------------

Event OnInit()
	If (self.IsRunning())
		StartTimer(1, LILAC_TIMER_ID)
	EndIf
EndEvent


Event OnTimer(int aiTimerID)
	RunTests()
EndEvent


; Methods
;---------------------------------------------

Function RunTests()
	LilacTrace(self, INFO, "Starting " + SystemName + " " + SystemVersion + " (API v" + APIVersion + ") on " + self)

	; Initial setup
	ResetTestRunner()
	SetUp()
	SetStartTime()
	beforeAll()
	beforeEach()

	; Execute test cases
	TestSuites()

	; Report results
	ShowTestFailureLog()
	ShowTestSummary()

	; Tear down
	afterEach()
	afterAll()
	self.Stop()
EndFunction


Function SetStartTime()
	last_current_time = Game.GetRealHoursPassed()
EndFunction


; Settings
;---------------------------------------------

Function EnableVerboseLogging()
	verbose_logging = true
EndFunction


Function EnableWarningOnSlowTests(float afWarningThreshold)
	warn_on_long_duration = true
	warning_threshold = afWarningThreshold
EndFunction


; Composition
;---------------------------------------------

Function Describe(string asTestSuiteName, bool abTestCases)
	current_test_suite = asTestSuiteName
	LogFailedTestSuites()
EndFunction


Function It(string asTestCaseName, bool abTestSteps)
	current_test_case = asTestCaseName
	LogFailedTestCases()

	string resultString
	float this_current_time = Game.GetRealHoursPassed()
	float deltaTimeSecs = (this_current_time - last_current_time) * 3600.0

	testsRun += 1
	If test_case_had_failures == false
		resultString = " SUCCESS"
		testsPassed	+= 1
	Else
		resultString = " FAILED"
		testsFailed	+= 1
	EndIf

	If testsFailed > 0
		If warn_on_long_duration && deltaTimeSecs > warning_threshold
			LilacTrace(self, WARN, "Executed " + testsRun + " (" + testsFailed + " FAILED)" + resultString + " (slow: " + deltaTimeSecs + " secs)")
		Else
			LilacTrace(self, INFO, "Executed " + testsRun + " (" + testsFailed + " FAILED)" + resultString + " (" + deltaTimeSecs + " secs)")
		EndIf
	Else
		If warn_on_long_duration && deltaTimeSecs > warning_threshold
			LilacTrace(self, WARN, "Executed " + testsRun + resultString + " (slow: " + deltaTimeSecs + " secs)")
		Else
			LilacTrace(self, INFO, "Executed " + testsRun + resultString + " (" + deltaTimeSecs + " secs)")
		EndIf
	EndIf
	last_current_time = this_current_time
	test_case_had_failures = false
	expectCount = 0

	; Tear down this test and set up the next one.
	afterEach()
	beforeEach()
EndFunction


Function Expect(var akActual, bool abCondition, int aiMatcher, var akExpected = none)

	If (akActual is Form)
		If (aiMatcher == BeEqualTo || aiMatcher == BeTruthy || aiMatcher == BeFalsy || aiMatcher == BeNone)
			If (aiMatcher >= 5) ; BeTruthy, BeFalsy, BeNone
				ExpectForm(akActual as Form, abCondition, aiMatcher)
			ElseIf (akExpected is Form)
				ExpectForm(akActual as Form, abCondition, aiMatcher, akExpected as Form)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf


	ElseIf (akActual is ObjectReference)
		If (aiMatcher == BeEqualTo || aiMatcher == BeTruthy || aiMatcher == BeFalsy || aiMatcher == BeNone)
			If (aiMatcher >= 5) ; BeTruthy, BeFalsy, BeNone
				ExpectRef(akActual as ObjectReference, abCondition, aiMatcher)
			ElseIf (akExpected is ObjectReference)
				ExpectRef(akActual as ObjectReference, abCondition, aiMatcher, akExpected as ObjectReference)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf


	ElseIf (akActual is int)
		If (aiMatcher != BeNone)
			If (aiMatcher >= 5) ; BeTruthy, BeFalsy
				ExpectInt(akActual as int, abCondition, aiMatcher)
			ElseIf (akExpected is int)
				ExpectInt(akActual as int, abCondition, aiMatcher, akExpected as int)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf


	ElseIf (akActual is float)
		If (aiMatcher != BeNone)
			If (aiMatcher >= 5) ; BeTruthy, BeFalsy
				ExpectFloat(akActual as float, abCondition, aiMatcher)
			ElseIf (akExpected is float)
				ExpectFloat(akActual as float, abCondition, aiMatcher, akExpected as float)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf akActual is bool
		If aiMatcher == BeEqualTo || aiMatcher == BeTruthy || aiMatcher == BeFalsy
			If aiMatcher >= 5 ; BeTruthy, BeFalsy
				expectBool(akActual as bool, abCondition, aiMatcher)
			ElseIf akExpected is bool
				expectBool(akActual as bool, abCondition, aiMatcher, akExpected as bool)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf akActual is string
		If aiMatcher == BeEqualTo || aiMatcher == BeTruthy || aiMatcher == BeFalsy
			If aiMatcher >= 5 ; BeTruthy, BeFalsy
				expectString(akActual as string, abCondition, aiMatcher)
			ElseIf akExpected is string
				expectString(akActual as string, abCondition, aiMatcher, akExpected as string)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	Else
		RaiseException_InvalidType(akActual)
	EndIf
EndFunction


Function ExpectForm(Form akActual, bool abCondition, int aiMatcher, Form akExpected = none)
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = akActual == (akExpected as Form)
		ElseIf aiMatcher == BeTruthy
			result = (akActual as bool) == true
		ElseIf aiMatcher == BeFalsy
			result = (akActual as bool) == false
		ElseIf aiMatcher == BeNone
			result = akActual == none
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; NotTo
		If aiMatcher == BeEqualTo
			result = akActual != (akExpected as Form)
		ElseIf aiMatcher == BeTruthy
			result = (akActual as bool) == false
		ElseIf aiMatcher == BeFalsy
			result = (akActual as bool) == true
		ElseIf aiMatcher == BeNone
			result = akActual != none
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, akActual as string, abCondition, aiMatcher, akExpected as string)
EndFunction


Function ExpectRef(ObjectReference akActual, bool abCondition, int aiMatcher, ObjectReference akExpected = none)
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = akActual == (akExpected as ObjectReference)
		ElseIf aiMatcher == BeTruthy
			result = (akActual as bool) == true
		ElseIf aiMatcher == BeFalsy
			result = (akActual as bool) == false
		ElseIf aiMatcher == BeNone
			result = akActual == none
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; NotTo
		If aiMatcher == BeEqualTo
			result = akActual != (akExpected as ObjectReference)
		ElseIf aiMatcher == BeTruthy
			result = (akActual as bool) == false
		ElseIf aiMatcher == BeFalsy
			result = (akActual as bool) == true
		ElseIf aiMatcher == BeNone
			result = akActual != none
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, akActual as string, abCondition, aiMatcher, akExpected as string)
EndFunction


Function ExpectInt(int aiActual, bool abCondition, int aiMatcher, int aiExpected = -1)
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = aiActual == aiExpected
		ElseIf aiMatcher == BeLessThan
			result = aiActual < aiExpected
		ElseIf aiMatcher == BeGreaterThan
			result = aiActual > aiExpected
		ElseIf aiMatcher == BeLessThanOrEqualTo
			result = aiActual <= aiExpected
		ElseIf aiMatcher == BeGreaterThanOrEqualTo
			result = aiActual >= aiExpected
		ElseIf aiMatcher == BeTruthy
			result = (aiActual as bool) == true
		ElseIf aiMatcher == BeFalsy
			result = (aiActual as bool) == false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; NotTo
		If aiMatcher == BeEqualTo
			result = aiActual != aiExpected
		ElseIf aiMatcher == BeLessThan
			result = aiActual >= aiExpected
		ElseIf aiMatcher == BeGreaterThan
			result = aiActual <= aiExpected
		ElseIf aiMatcher == BeLessThanOrEqualTo
			result = aiActual > aiExpected
		ElseIf aiMatcher == BeGreaterThanOrEqualTo
			result = aiActual < aiExpected
		ElseIf aiMatcher == BeTruthy
			result = (aiActual as bool) != true
		ElseIf aiMatcher == BeFalsy
			result = (aiActual as bool) != false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, aiActual as string, abCondition, aiMatcher, aiExpected as string)
EndFunction


Function ExpectFloat(float afActual, bool abCondition, int aiMatcher, float afExpected = -1.0)
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = afActual == afExpected
		ElseIf aiMatcher == BeLessThan
			result = afActual < afExpected
		ElseIf aiMatcher == BeGreaterThan
			result = afActual > afExpected
		ElseIf aiMatcher == BeLessThanOrEqualTo
			result = afActual <= afExpected
		ElseIf aiMatcher == BeGreaterThanOrEqualTo
			result = afActual >= afExpected
		ElseIf aiMatcher == BeTruthy
			result = (afActual as bool) == true
		ElseIf aiMatcher == BeFalsy
			result = (afActual as bool) == false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; NotTo
		If aiMatcher == BeEqualTo
			result = afActual != afExpected
		ElseIf aiMatcher == BeLessThan
			result = afActual >= afExpected
		ElseIf aiMatcher == BeGreaterThan
			result = afActual <= afExpected
		ElseIf aiMatcher == BeLessThanOrEqualTo
			result = afActual > afExpected
		ElseIf aiMatcher == BeGreaterThanOrEqualTo
			result = afActual < afExpected
		ElseIf aiMatcher == BeTruthy
			result = (afActual as bool) != true
		ElseIf aiMatcher == BeFalsy
			result = (afActual as bool) != false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, afActual as string, abCondition, aiMatcher, afExpected as string)
EndFunction


Function expectBool(bool abActual, bool abCondition, int aiMatcher, bool abExpected = false)
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = abActual == abExpected
		ElseIf aiMatcher == BeTruthy
			result = abActual == true
		ElseIf aiMatcher == BeFalsy
			result = abActual == false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; NotTo
		If aiMatcher == BeEqualTo
			result = abActual != abExpected
		ElseIf aiMatcher == BeTruthy
			result = abActual != true
		ElseIf aiMatcher == BeFalsy
			result = abActual != false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, abActual as string, abCondition, aiMatcher, abExpected as string)
EndFunction


Function expectString(string asActual, bool abCondition, int aiMatcher, string asExpected = "")
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = asActual == asExpected
		ElseIf aiMatcher == BeTruthy
			result = (asActual as bool) == true
		ElseIf aiMatcher == BeFalsy
			result = (asActual as bool) == false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; NotTo
		If aiMatcher == BeEqualTo
			result = asActual != asExpected
		ElseIf aiMatcher == BeTruthy
			result = (asActual as bool) != true
		ElseIf aiMatcher == BeFalsy
			result = (asActual as bool) != false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, asActual, abCondition, aiMatcher, asExpected)
EndFunction


; Reports
;---------------------------------------------

Function LogFailedTestSuites()
	int end_index = ArrayCountString(failedActuals) - 1
	If end_index == -1
		return
	EndIf
	int start_index = ArrayCountString(failedTestSuites)

	int i = start_index
	While i <= end_index
		failedTestSuites[i] = current_test_suite
		i += 1
	EndWhile
EndFunction


Function LogFailedTestCases()
	int end_index = ArrayCountString(failedActuals) - 1
	If end_index == -1
		return
	EndIf
	int start_index = ArrayCountString(failedTestCases)

	int i = start_index
	While i <= end_index
		failedTestCases[i] = current_test_case
		i += 1
	EndWhile
EndFunction


Function ResetTestRunner()
	failedTestSuites = new string[128]
	failedTestCases = new string[128]
	failedActuals = new string[128]
	failedConditions = new bool[128]
	failedMatchers = new int[128]
	failedExpecteds = new string[128]
	failedExpectNumbers = new int[128]

	testsRun = 0
	testsPassed = 0
	testsFailed = 0
	expectCount = 0
	last_current_time = -1.0
	current_test_suite = ""
	current_test_case = ""
	verbose_logging = false
	warn_on_long_duration = false
	warning_threshold = 0.0
EndFunction


Function ShowTestFailureLog()
	int working_index = 0
	bool failed_tests_msg_shown = false

	string current_working_test_suite = ""
	bool processing_suites = true
	While processing_suites
		If failedTestSuites[working_index] != ""
			current_working_test_suite = failedTestSuites[working_index]
			If !failed_tests_msg_shown
				LilacTrace(self, INFO, "Failed Tests (first 128 failed test steps shown):")
				failed_tests_msg_shown = true
			EndIf
			LilacTrace(self, INFO, " - " + failedTestSuites[working_index] + ":")

			string current_working_test_case = ""
			bool processing_cases = true
			While processing_cases
				bool processing_steps = true
				If failedTestCases[working_index] != ""  && failedTestSuites[working_index] == current_working_test_suite
					current_working_test_case = failedTestCases[working_index]
					LilacTrace(self, INFO, "    - " + failedTestCases[working_index] + ":")

					While processing_steps
						If failedActuals[working_index] != "" && failedTestCases[working_index] == current_working_test_case
							LilacTrace(self, INFO, CreateStepFailureMessage(working_index))
							working_index += 1
						Else
							processing_steps = false
						EndIf
					EndWhile
				Else
					processing_cases = false
				EndIf
			EndWhile
		Else
			processing_suites = false
		EndIf
	EndWhile
EndFunction


Function ShowTestSummary()
	LilacTrace(self, INFO, "  " + testsRun + " total  " + testsPassed + " passed  " + testsFailed + " failed")
EndFunction


string Function CreateStepFailureMessage(int index)
	bool cdtn_val = failedConditions[index]
	int matcher_val = failedMatchers[index]
	string actual_val = failedActuals[index]
	string expected_val = failedExpecteds[index]
	int expectnumber_val = failedExpectNumbers[index]

	string header = "        - Expect " + expectnumber_val + ": expected"

	;Debug.Trace("Creating step failure message from index " + index + " " + cdtn_val  + " " + matcher_val + " " + actual_val + " " + expected_val)

	string cdtn
	If failedConditions[index] == true
		cdtn = "To"
	Else
		cdtn = "not To"
	EndIf

	string matcher
	If matcher_val == BeEqualTo
		matcher = "be equal To"
	ElseIf matcher_val == BeLessThan
		matcher = "be less than"
	ElseIf matcher_val == BeLessThanOrEqualTo
		matcher = "be less than or equal To"
	ElseIf matcher_val == BeGreaterThan
		matcher = "be greater than"
	ElseIf matcher_val == BeGreaterThanOrEqualTo
		matcher = "be greater than or equal To"
	ElseIf matcher_val == BeTruthy
		matcher = "be truthy"
	ElseIf matcher_val == BeFalsy
		matcher = "be falsy"
	ElseIf matcher_val == BeNone
		matcher = "be none"
	EndIf

	string msg

	If matcher_val == BeTruthy || matcher_val == BeFalsy || matcher_val == BeNone
		msg = header + " " + actual_val + " " + cdtn + " " + matcher
	Else
		msg = header + " " + actual_val + " " + cdtn + " " + matcher + " " + expected_val
	EndIf

	return msg
EndFunction


string Function CreateVerboseStepMessage(bool abResult, string asActual, bool abCondition, int aiMatcher, string asExpected, int aiNumber)
	bool cdtn_val = abCondition
	int matcher_val = aiMatcher
	string actual_val = asActual
	string expected_val = asExpected
	int expectnumber_val = aiNumber

	string header = " - Expect " + expectnumber_val + ": expected"

	string result
	If abResult == true
		result = "PASSED"
	Else
		result = "FAILED"
	EndIf

	string cdtn
	If cdtn_val == true
		cdtn = "To"
	Else
		cdtn = "not To"
	EndIf

	string matcher
	If matcher_val == BeEqualTo
		matcher = "be equal To"
	ElseIf matcher_val == BeLessThan
		matcher = "be less than"
	ElseIf matcher_val == BeLessThanOrEqualTo
		matcher = "be less than or equal To"
	ElseIf matcher_val == BeGreaterThan
		matcher = "be greater than"
	ElseIf matcher_val == BeGreaterThanOrEqualTo
		matcher = "be greater than or equal To"
	ElseIf matcher_val == BeTruthy
		matcher = "be truthy"
	ElseIf matcher_val == BeFalsy
		matcher = "be falsy"
	ElseIf matcher_val == BeNone
		matcher = "be none"
	EndIf

	string msg

	If matcher_val == BeTruthy || matcher_val == BeFalsy || matcher_val == BeNone
		msg = header + " " + actual_val + " " + cdtn + " " + matcher + " " + result
	Else
		msg = header + " " + actual_val + " " + cdtn + " " + matcher + " " + expected_val + " " + result
	EndIf

	return msg
EndFunction


Function RaiseResult(bool abResult, string asActual, bool abCondition, int aiMatcher, string asExpected)
	expectCount += 1
	If abResult == false
		test_case_had_failures = true
		int idx
		If asActual != ""
			idx = ArrayAddString(failedActuals, asActual as string)
		Else
			idx = ArrayAddString(failedActuals, "(empty string)")
		EndIf
		If idx != -1
			failedConditions[idx] = abCondition
			failedMatchers[idx] = aiMatcher
			failedExpectNumbers[idx] = expectCount
			If asExpected != ""
				failedExpecteds[idx] = asExpected
			Else
				failedExpecteds[idx] = "(empty string)"
			EndIf
		EndIf
	EndIf
	If (verbose_logging)
		string msg = CreateVerboseStepMessage(abResult, asActual, abCondition, aiMatcher, asExpected, expectCount)
		LilacTrace(self, INFO, msg)
	EndIf
EndFunction




int Function ArrayAddString(string[] myArray, string myKey)
    int i = 0
    While i < myArray.Length
        If IsNone(myArray[i])
            myArray[i] = myKey
            return i
        Else
            i += 1
        EndIf
    EndWhile
    return -1
EndFunction


int Function ArrayCountString(string[] myArray)
    int i = 0
    int myCount = 0
    While i < myArray.Length
        If !(IsNone(myArray[i]))
            myCount += 1
            i += 1
        Else
            i += 1
        EndIf
    EndWhile
    return myCount
EndFunction


bool Function IsNone(string akString)
    If akString
        If akString == ""
            return true
        Else
            return false
        EndIf
    Else
        return true
    EndIf
EndFunction


; Expectations
;---------------------------------------------

bool Function expectIsNotNone(var aValue) ; unsupported
	Expect(aValue as bool, To, BeTruthy)
	return Done
EndFunction


bool Function expectStringHasText(string asValue) ; unsupported
	expectIsNotNone(asValue)
	Expect(asValue, NotTo, BeEqualTo, "")
	return Done
EndFunction


; Exceptions
;---------------------------------------------

Function RaiseException_InvalidMatcher(int aiMatcher)
	string matcher
	If aiMatcher == 0
		matcher = "BeEqualTo"
	ElseIf aiMatcher == 1
		matcher = "BeLessThan"
	ElseIf aiMatcher == 2
		matcher = "BeLessThanOrEqualTo"
	ElseIf aiMatcher == 3
		matcher = "BeGreaterThan"
	ElseIf aiMatcher == 4
		matcher = "BeGreaterThanOrEqualTo"
	ElseIf aiMatcher == 5
		matcher = "BeTruthy"
	ElseIf aiMatcher == 6
		matcher = "BeFalsy"
	ElseIf aiMatcher == 7
		matcher = "BeNone"
	EndIf
	LilacTrace(self, ERROR, "Invalid matcher '" + matcher + "' used.")
EndFunction


Function RaiseException_InvalidType(var akActual)
	LilacTrace(self, ERROR, "Actual " + (akActual as string) + " was not a Form, ObjectReference, int, float, bool, or string.")
EndFunction


Function RaiseException_NonMatchingType(var akActual, var akExpected)
	LilacTrace(self, ERROR, "Actual " + (akActual as string) + " did not match the type of Expected " + (akExpected as string))
EndFunction


; Virtuals
;---------------------------------------------

Function SetUp()
	{VIRTUAL}
EndFunction

Function TestSuites()
	{VIRTUAL}
EndFunction

Function beforeAll()
	{VIRTUAL}
EndFunction

Function afterAll()
	{VIRTUAL}
EndFunction

Function beforeEach()
	{VIRTUAL}
EndFunction

Function afterEach()
	{VIRTUAL}
EndFunction


; Properties
;---------------------------------------------

Group Lilac
	string Property SystemName = "Lilac" AutoReadOnly
	float Property SystemVersion = 1.2 AutoReadOnly
	int Property APIVersion = 2 AutoReadOnly
EndGroup

Group Runner
	string[] Property failedTestSuites Auto Hidden
	string[] Property failedTestCases Auto Hidden
	string[] Property failedActuals Auto Hidden
	bool[] Property failedConditions Auto Hidden
	int[] Property failedMatchers Auto Hidden
	string[] Property failedExpecteds Auto Hidden
	int[] Property failedExpectNumbers Auto Hidden
	int Property expectCount = 0 Auto Hidden
	int Property LILAC_TIMER_ID = 0x212AC Auto Hidden
EndGroup

Group Conditions
	bool Property To 					= true 	AutoReadOnly
	bool Property NotTo					= false	AutoReadOnly
EndGroup
Group Matchers
	int Property BeEqualTo 				= 0		AutoReadOnly
	int Property BeLessThan 			= 1		AutoReadOnly
	int Property BeLessThanOrEqualTo 	= 2		AutoReadOnly
	int Property BeGreaterThan 			= 3		AutoReadOnly
	int Property BeGreaterThanOrEqualTo	= 4		AutoReadOnly
	int Property BeTruthy 				= 5		AutoReadOnly
	int Property BeFalsy 				= 6		AutoReadOnly
	int Property BeNone					= 7		AutoReadOnly
EndGroup
Group LogLevel
	int Property INFO 					= 0 	AutoReadOnly
	int Property WARN 					= 1 	AutoReadOnly
	int Property ERROR 					= 2 	AutoReadOnly
EndGroup
Group Constants
	bool Property Done = true AutoReadOnly ; for dummy function return
EndGroup
