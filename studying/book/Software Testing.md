# **Software Testing Short Notes for Every Chapter**
---

## Chapter 1 - Software Testing Background
---

- A software bug occurs when one or more of the following five rules is true:
	1. The software doesn't do something that the product specification says it should do.
	2. The software does something that the product specification says it shouldn't do.
	3. The software does something that the product specification doesn't mention.
	4. The software doesn't do something that the product specification doesn't mention but should.
	5. The software is difficult to understand, hard to use, slow, or--in the software tester's eyes--will be viewed by the end user as just plain not right.
- Who cause bugs?
	- Specification > Design > Code(programming) > Other
- The cost of bugs when you solve it:
	- Release > Test > Code > Design > Specification


## Chapter 2 - The Software Development Process
---

- Better study more complete and new reading, article, etc.


## Chapter 3 - The Realities of Software Testing
---

- Precision and Accuracy
    + An example in dart game, 
        * Accuracy means you hit near target.
        * Precision means you hit concentratedly(always hit the same place).
    + It can be \"Neither Accurate nor Precise\", \"Precise, but not Accurate", \"Accurate, but not Precise", "Accurate and Precise".
- Verification and Validation
    + Verification
        * The product statisifies the specification.
    + Validation
        * The product statistifies the user's requirement.
    + There is a possisible situation that the verification is good as well as the validation is bad if the specification isn't that great.
- Quality and Reliability
    + Quality
        * We say that the product is of high quality if it met customer's needs great.
    + Reliability
        * We say that the product is of high reliability if it nearly never crashes and trashes his data.
    + In fact, Reilability is one of the Quality.
- Testing and Quality Assurance (QA)
    + Testing
        * The goal is to find bugs, and make sure they get fixed.
    + Quality Assurance
        * Create or enforce standards and methods to improve the development process and to prevent bugs from ever occuring.



# Chapter 4 Examing the Specification
---

- Black-Box Testing
    + You test it when you don't actually know about the detail inside the box(what the code actually does).
    + Sometimes, Black-Box Testing is referred to as functional testing or behavioral testing by meaning.
- White-Box Testing
    + You test it when you know about the detail inside the box.
    + Be aware of stepping into the trap that you tailor(fit) the tests to match the code's operation.
- Static Testing
    + Test something that is not running.
- Dynamic Testing
    + Test somethinh that is running.
- Static Black-Box Testing
    + Test the specification
- High-Level Review of the Specification
    + Pretebd to Be the Customer
        * Check the spec if it meet the customer's need or not.
    + Research Existing Standard and Guidelines
        * Standards should be strictly adhered to if your team has decided that it's import to comply with them completely.
        * Guidelines are optional but should be followed.
        * Corporate Terminology and Conventions
            - It should adopt the common terms and conventions used by the users.
        * Industry Requirements
        * Government Standards
        * GUI
        * Security Standards
    + Review and Test Similar Software
        * Scale
        * Complexity
        * Testability
        * Quality/Reliability
        * Security
- Low-Level Specification Test Techniques
    + Specification Attributes Checklist
        * Complete
            - Is anything missing or forgotten?
            - Is it thorough?
            - Does it include everything necessary to make it stand alone.
        * Accurate
            - Is the proposed solution correct?
            - Does it properly define the goal?
            - Are there any errors?
        * Precise, Unambiguous, and Clear
            - Is the description exact and not vague?
            - Is there a single interpretation?
            - Is it easy to read and understand?
        * Consistent
            - Is the description of the feature written so that it doesn't conflict with itself or other items in the specification?
        * Relevant
            - Is the statement necessary to specify the feature?
            - Is it extra information that should be left out?
            - Is the feature traceable to an original customer?
        * Feasible
            - Can the feature be implemented with the available personnel, tools, and resources within the specified budget and schedule?
        * Code-free
            - Does the specification stick with defining the product and not the underlying software design, architecture, code?
        * Testable
            - Can the feature be tested?
            - Is enough information provided that a tester could create tests to verify its operation?
    + Specification Terminology Checklist
        * Always, Every, All, None, Never
            - 必須遵守，不可違反。
        * Certainly, Therefore, Clearly, Obvious, Evidently
            - 說服你接受，Don't fall into trap。
        * Some, Sometimes, Often, Usually, Ordinarily, Customarily, Most, Mostly
            - 過於模糊，不可測試。
        * Etc, And So Forth, And So on, Such as
            - 不該用，因為其不明確而無法測試。
        * Good, Fast, Cheap, Efficient, Small, Stable
            - 不該用，因為其不可量化而無法測試。
        * Handled, Processed, Rejected, Skipped, Eliminated
            - 會隱藏大量需要 specify 的功能(functionality)
        * If...Then...
            - 須確定 else 會發生甚麼。


# Chapter 5 Testing the Software with Blinders On
---

- Test-to-Pass
    + 測試軟體是否可以在舒適的環境下運行，像是測試新車最基本的能不能動、能不能上路(輪胎尺寸對不對、引擎吵不吵、剎車有沒有用等等)。
- Test-to-Fail
    + 用嚴苛的條件、環境測試軟體的能耐，像是測試新車能不能每秒加速達到 spec 上的數據等等。
- Equivalence Partitioning
    + 將 Test Case 依其等價性做精煉。
- Data Testing
    + Boundary Contitions
        * Types of Boundary Conditions
            - Numeric, Character, Position, Quantity, Speed, Location, Size
        * Characteristics of Those Types
            - First/Last, Start/Finish, Min/Max, Over/Under, Empty/Full, Slowest/Fastest, Largest*Smallest, Next-To/Farthest-From, Shortest/Longest, Soonest/Latest, Highest/Lowest
    + Sub-Boundary Conditions
        * Power of two
        * ACSII
    + Default, Empty, Blank, Null, Zero, and None
    + Invalid, Wrong, Incorrect, and Garbage Data
- State Testing
    + Testing the Software's Logic Flow
        * Creating a State Transition Map
            - Each unique state that the software can be in.
            - The input or condition that takes it from one state to the next.
            - Set conditions and produced output when a state is entered or exited.
        * Reducing the Number of States and Transitions to Test
            - 至少進入過全部的狀態一次，不論手法。
            - 測試最容易使用、進入的狀態(static black-box analysis)。
            - 測試 state 間最常走的path。
            - 測試所有的 error states ，確保它是存在、正確的及其返回值亦為正確。
        * What to Specifically Test
    + Testing States to Fail
        * Race Conditions and Bad Timing
            - Saving and loading the same document at the same time with two different program.
            - Sharing the same printer, communications port, or other peripheral.
            - Pressing keys or sending mouse clicks while the software is loading or changing states.
            - Shutting down or starting up two or more instances of the software at the same time.
            - Using different programs to simultaneously access a common database.
        * Repetition, Stress, and Load
            - Repetition: 測其重複執行的狀況，重點是有沒有 memory leak 。
            - Stress: 在環境條件很差的情況下做測試，如低記憶體、低CPU等等。
            - Load: 用好的環境測試軟體是否能負擔預期的負荷量。
- Other Black-Box Test Techniques
    + Behave Like a Dumb User
    + Look for Bugs Where You;ve Already Found Them
    + Think like a Hacker
    + Follow Experience, Intution, and Hunches


# Chapter 6 Examining the Code
---

- Generic Code Review Checklist
    + Data Reference Errors
    + Data Declaration Errors
    + Computation Errors
    + Comparison Errors
    + Control Flow Errors
    + Subroutine Parameter Errors
    + Input/Output Errors
    + Other Checks

# Chapter 7 Testing the Software with X-Ray Glasses
---

- Data Coverage
    + Data Flow
        * track a piece of data completely through the software
    + Sub-Boundaries
        * some case in special situations
    + Formulas and Equations
        * apply some special test case for them
    + Error Forcing
        * force the variables to specific values by watching them with a debugger
- Code Coverage
    + Program Statement and Line Coverage
        * execute every statement ing the program at least once
    + Branch Coverage
        * one path testing is branch coverage testing
        * cover all the path is called path testing
    + Condition Coverage
        * test all the condition

# Chapter 8 Configuration Testing
---
