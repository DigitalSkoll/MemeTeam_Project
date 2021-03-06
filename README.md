# MemeTeam_Project
Team Project, Grade DMV test using intel x86 assembly
##Team Project Instructions

Mid-Term Exam: Thursday April 13, 2017
Team Project Due: Thursday April 13, 2017
/*Presentations before exam*/

Each Presentation = 5-8 Minutes


1. Design your Console user interface using the appropriate layout and screen 
   placement to be efficient and effective for the operator grading the 
   examinations. Your project MUST include a Menu with AT LEAST these options.
            STATE DMV DRIVERS EXAMINATION
            -----------------------------
            1. Enter Applicant Data File Name
            2. Grade Applicant Examination
            3. Display Applicant Results
            4. Exit the Program
            -----------------------------
            Enter Option 1, 2, 3, or 4:
            
2. *Option 1:* The DMV examiner will use the KEYBOARD (and the 'C' scanf() function)
	 to enter the FILENAME containing each driver license applicant's exam answers
 	 (Hint: Place ALL data files into a Folder named Datafiles located in the same
	 directory as the project's executable (.exe) and source code (.asm) files. That
	 will make the 'path' to those files easier to specift in your program code by 
	 simply using ".\\Datafiles\\" + the concatenated string FILENAME value entered
	 by the DMV examiner in Menu Option 1). Make appropriate SCREEN CAPTURES as the 
	 application is running to demonstrate functionality of your final Menu design 
	 and this option's operation.
3. *Option 2:* The completed DMV examination grading application will perform the
 	 following operations
                        
                        a) *DISPLAY* the following *HEADING centered* under the Menu area
	               on the console screen using the 'C' printf() function.
                        <blank>
                        <blank>
                        Applicant  xxxxyyy.dat
                        <blank>
                              DMV     APPLICANT
                           -----------------------
                        <blank>
                        <blank>
                        
                        b) *OPEN BOTH* the *CORRECT ANSWERS* data file and the *CURRENT 
                           APPLICANT'S* data file. *READ* the current answer record from
                           each of those data files into the respective string variables.
                           COMPARE the two answers. If they *MATCH ADD 1* to the counter
                           variable for the *CORRECT* answers.
                        
                        c) Use the 'C' printf() function to *DISPLAY* the *CORRECT DMV 
                           answer AND the APPLICANT'S answer* like this, if the applicant's
                           answer is *_CORRECT_*.
                                                A           A
                           *OR* like this, if the applicant's answer is *_INCORRECT_*.
                                                A           D x         <-- x means incorrect
                        d) REPEAT *Step 3b* and *Step 3c* until BOTH data files achieve the 
                           *EOF* condition. Then, make a *SCREEN CAPTURE* to demonstrate the
                           results for *THIS* applicant.
4. *Option 3*: The DMV operator provides the applicants *exam result (PASS or FAIL)'*.
   Your Team's code will implement a decision structure to determine if the *applicant
   met the minimum number of correct answers to pass* the examination. The applicant must
   answer *at least _15_ questions correctly in order to 'pass'*. Have the progam logic 
   indicate "*PASS*" or "*FAIL*" akibg wutg the *_number of questions answered CORRECTLY_*
   for the current applicant. *Your Team* will decide on the *appriate text messages and 
   layout to use for displaying this information* on the console screen.
   			a) Use the following alyout as an *_EXAMPLE_* for how the results might
			   be displayed on the screen. *YOU SHOULD CREATE YOUR OWN LAYOUT AND 
			   DISPLAY FOR THE INFORMATION* (as long as it includes the same basic
			   information about the test results for an applicant).
			   _DO NOT USE THIS AS YOUR OWN DESIGN_.
			   		
					Department of Motor Vehicles
					 Driver's Exam for xxxxyyy
					 
				   You answered 99 questions, correctly.   <-- 99 is the number of correct answers.
				   
				Your result on this portion of the exam is: XXXX <-- Print PASS or FAIL
				
			b) Make a *SCREEN CAPTURE* of *_YOUR Option 3 layout_* for *EACH 
			   applicant's results*.

5. There are two applicant files, *3045WIL.dat* and *9831GRA.dat* to use. Run the 
   program using *EACH* of these files as described in *Step 1, Step 2, and Step 3.*
