# Coin Vue

<img src="https://github.com/jurmadani/CoinVue/assets/102948701/bc6af646-c838-4926-aa3b-60dd54d20b37" align="left">

CoinVue is a Swift & SwiftUI application that allows users to track cryptocurrency prices and trends. It leverages the MVVM architecture, Combine framework, Core Data for data persistence, and the CoinGecko API for real-time cryptocurrency data.

## 🔗 Developer

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/daniel-jurma/)



## Key Features

- **CoinGecko API Integration:** Utilizes CoinGecko API to fetch real-time data on various cryptocurrencies.

- **Dynamic Coin List:** Displays a scrollable list of cryptocurrencies and implements filtering options for users to easily find specific coins.

- **Marketplace Information:** Provides essential marketplace data, including 24-hour volume and market capitalization for each cryptocurrency.

- **Portfolio Management:** Allows users to add and track their cryptocurrency holdings and calculates and displays the real-time value of the user's portfolio based on current market data.
  
- **Coin Details:** Enables users to click on a specific coin to view detailed information and displays a price chart illustrating the coin's performance over the past week.

## Solution Approach

### MVVM Architecture

The CoinVue app is designed following the MVVM (Model-View-ViewModel) architecture, promoting a clear separation of concerns and maintainability. The structure is organized into three main components:

- **Model:** Represents the data and business logic. In this app, it includes the data models for cryptocurrencies and portfolio holdings.

- **View:** Displays the user interface, ensuring a responsive and visually appealing design. SwiftUI is utilized for building the UI components.

- **ViewModel:** Acts as an intermediary between the Model and View. It handles data transformation and manipulation, as well as communication with the backend through Combine publishers.

### Combine Framework and Publishers/Subscribers

Combine framework is extensively used for handling asynchronous operations and managing data flow within the app. Publishers and subscribers are employed to establish a reactive data flow, ensuring real-time updates and efficient handling of API responses. For example:

- API calls are wrapped in Combine publishers, allowing seamless integration with the CoinGecko API.
  
- Data updates trigger subscribers, ensuring UI components reflect the latest information.

### CoreData for Data Persistence

CoreData is employed for efficient data persistence, enabling users to store and manage their cryptocurrency portfolios. The app uses CoreData entities to represent the different data models and ensures a robust and scalable solution for storing user-related information locally.

### Multi-Threading

To enhance app performance and responsiveness, multi-threading techniques are implemented. Key tasks, such as API calls and data processing, are offloaded to background threads, preventing UI freezes and ensuring a smooth user experience.

### Summary

The combination of MVVM architecture, Combine framework, CoreData for data persistence, and multi-threading practices results in a well-organized, reactive, and performant solution. CoinVue offers a user-friendly experience for tracking cryptocurrency data, managing portfolios, and staying updated with real-time market information.

## Technologies Used

<img src="https://github.com/jurmadani/TwitterClone/assets/102948701/851a1690-b95a-43d1-9414-56647abba5ec"
width="200" hspace="10" vspace="10">
<img src="https://github.com/jurmadani/TwitterClone/assets/102948701/fa06941f-e2a9-4685-b710-03d4716b9ced"
width="200" hspace="10" vspace="10">
<img src="https://github.com/jurmadani/TwitterClone/assets/102948701/b79c1069-e4fb-4906-81af-d333aa2e8c2f"
width="200" hspace="10" vspace="10">
<img src="https://github.com/jurmadani/TwitterClone/assets/102948701/e8824dfa-9334-4af1-8f4d-884c7127eec2"
width="200" hspace="10" vspace="10">


- **Xcode:** The integrated development environment for building iOS applications.
- **Swift:** The programming language used for building native iOS applications.
- **SwiftUI:** A modern UI framework for building user interfaces across all Apple platforms.
- **SF Symbols:** Apple's iconography system for scalable and customizable symbols.


## Configuration

Before running the application, ensure you have Xcode installed and follow the steps below:

### CoinVue - Crypto Tracker with SwiftUI

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/jurmadani/CoinVue.git
     
1. Open the Xcode project file:

   ```bash
   cd CoinVue
   open CoinVue.xcodeproj


## Screnshots

<img src="https://github.com/jurmadani/CoinVue/assets/102948701/6c171e28-4d8f-4e2b-80a9-4f03ae9ea1ea"
width="200" hspace="10" vspace="10">
<img src="https://github.com/jurmadani/CoinVue/assets/102948701/4784c974-88d9-40c0-9188-fed5ec73b397"
width="200" hspace="10" vspace="10">
<img src="https://github.com/jurmadani/CoinVue/assets/102948701/31a2c620-02e6-4847-9998-10162c052848"
width="200" hspace="10" vspace="10">
<img src="https://github.com/jurmadani/CoinVue/assets/102948701/9232c0f9-2d92-4622-aaac-dd21d3cfb827"
width="200" hspace="10" vspace="10">
<img src="https://github.com/jurmadani/CoinVue/assets/102948701/46558f0e-8ab3-4f54-9093-cb5ca540672a"
width="200" hspace="10" vspace="10">
<img src="https://github.com/jurmadani/CoinVue/assets/102948701/95b9aec8-521d-4273-b639-c0cc7f0bf17b"
width="200" hspace="10" vspace="10">







## Demo Video

https://github.com/jurmadani/CoinVue/assets/102948701/aea5fe2c-7b89-4169-bf34-68449984b9c6


## Project Approach

- **Understanding Project Requirements:** Conducted a thorough analysis of project requirements, focusing on key features and functionalities for the SwiftUI Coin Vue application.

- **Evaluation of Technologies:** Explored and assessed technologies and frameworks suitable for SwiftUI, Swift, and SF Symbols to ensure optimal cross-platform compatibility, performance, and an enhanced developer experience.

- **Development Environment Setup:** Configured the development environment, leveraging Xcode as the primary IDE for SwiftUI and Swift development. Ensured the inclusion of essential tools, libraries, and dependencies.

- **Modular Architecture Design:** Implemented a modular architecture pattern to enhance code organization and maintainability. Utilized small, reusable components to facilitate separation of concerns and enable efficient testing.

- **Git for Collaboration:** Employed Git for collaborative development, effective code management, and tracking changes. Utilized version control to streamline collaboration among project contributors.

This approach ensured a structured development process, leveraging SwiftUI and Swift to create a visually appealing Coin Vue with a focus on modularity, maintainability, and collaboration.


## Contributing
Whether you use this project, have learned something from it, or just like it, please consider supporting it by buying me a coffee, so I can dedicate more time on building open-source projects like this :)

<a href="https://www.buymeacoffee.com/djurma" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="60px" width="217px" />
</a>

## License
The Coin Vue is open-source and released under the [GNU General Public License](https://choosealicense.com/licenses/gpl-3.0/)

## Contact
For any inquiries or questions regarding the Coin Vue application, please contact me at d_jurma@yahoo.com





    
