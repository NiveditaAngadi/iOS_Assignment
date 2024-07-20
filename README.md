# iOS_Assignment
Assignment for the implementation for iOS Application.

Goal is to display a list of deals currently offered and when user tap on one of the deals show the details infromation.

API infromation and UI/UX design has been provided. 

## Software Design:
Application has designed and implemented using MVVM design pattern. 

### Unit tests 
Test cases are written to verify the fetch information from the API.

### Network design 
Generic network layer is written to fetch information from the 

### Error handling:
Following errors has handled, 
1. Network error
2. Decode error
3. Domain Error
4. Url Error

Errors are displayed in the form of Alert to end users. 

### View State managment 
Following states are maintained for information fetch from end points, and application response as per the state.

View State
1. Idle 
2. Start loading
3. Success
4. Error 

Note: Provided sample project (Placeholder app) deployment target is iOS 13, hence wrote a wrapper for supporting async feature in Network call using "withCheckedThrowingContinuation". 







