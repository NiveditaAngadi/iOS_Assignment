## Target iOS Case Study
You have been given control over an iOS project that was originally a proof-of-concept project. The original developer of the project has since moved on to a new team,
and Target has asked you to turn the project into an application that the company could release to the public.

The goal of the app is to display a list of deals currently offered by Target, and to provide information on those deals.
As a POC, the app has a few deals hardcoded in and the code is pretty rough. It is your job to turn this app into something useful!

#### Requirements
1. Fix up the list to match the item listing page design shown in the [mockups](https://www.figma.com/file/bJmbkTubmeeQCpD9c0RgjZ/iOS-Technical-Screener). Do your best to match the fonts, colors, and margins from the mockups. We don't expect your implementation to be pixel-perfect.
2. Present the item detail page when an item is tapped on the list screen. Again, match the design shown in the [mockups](https://www.figma.com/file/bJmbkTubmeeQCpD9c0RgjZ/iOS-Technical-Screener) as best you can.
3. The deals are currently hardcoded. Use the API at [https://api.target.com/mobile_case_study_deals/v1](https://api.target.com/mobile_case_study_deals/v1) to grab the real deals to display in the app. Your solution should make use of both of the API endpoints:
      * Product List Endpoint: 
        [https://api.target.com/mobile_case_study_deals/v1/deals](https://api.target.com/mobile_case_study_deals/v1/deals)
        
      * Product Details Endpoint:
        `https://api.target.com/mobile_case_study_deals/v1/deals/{productId}`
        
        [Test Product Details for Product 1](https://api.target.com/mobile_case_study_deals/v1/deals/1)

_Note: Please use UIKit at least for the deals list. While engineers are building SwiftUI experiences in the Target app today (and empowered to do so), UIKit will remain a part of the iOS landscape for some time._

#### Guidelines
- Feel free to use any open source software you wish. Be prepared to answer questions about why you chose any libraries that you add to the project.
- Treat this app as something you control technically. The way you chose to architect your solution will be a key aspect of the case study review.
- This project was only tested minimally during development.  There may be bugs in the current implementation.
- Do your best to follow modern iOS conventions.
- Imagine that this app will continue to grow after you are done. Consider and be ready to discuss how the following engineering values fit into your chosen solution:
	- Clean, well organized code
	- Modern UI patterns
	- Networking design
	- Error handling
	- Testability
	- Reusability
	- Support for different screen sizes
