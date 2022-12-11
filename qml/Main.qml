import Felgo 3.0
import QtQuick 2.5
import "model"

// The app is the manager of your class. It owns the different components
// like the pages and the data model. Also, it connects the individual
// signals from its sub-components to corresponding slots.
App {
    id: app
    // TODO: You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    licenseKey: "964E7518A1F68B55F3EE090AE3A459DBA38856F194FD79455F3B52532606302E456764AFB4F4DE44A9245FE2C727B018219A0D48B1DAD72EE08A944C25E0D4D04A0AA4399F5EAB667186549A742A09BD85823F49DFB4E3F35CE211CC4F0BC61AF249FE4DF819457D434839FABBF94F0568C98DA7FF04A4A1F1EAC024379E23150DD2480AB937EA9832D71027F4E52DE86D8B4BFB7950FE07EF4208FD9D55614800BF5094CE5FEA2FE96D0B55FFFAAB27151D13B7E45A871350230222F1FABAEF1925D625C71B48598EA62B80708DCBAB0B0B0F1E0D82778228F21F06BBD2EA1B82F57F722B7B78FA6F105392C1E02A057F4847F8B70AE90FD5A99AD864521D3FBF15B37CF89580C6AF464398E8B99549722CFF983CF1A4A41F6006484A1AAF1D381C75D140258263C61EFF7F5D193992"

    // The data model manages the shopping list data and authentication
    // in the Google Firebase Realtime Database.
    // It also abstracts the Google Firebase database, so that
    // the rest of your application doesn't need to worry about
    // how exactly the data is stored or accessed.
    DataModel {
        id: dataModel
        // After the login-process has been finished successfully,
        // navigate from the login page to the shopping list page
        onLoggedIn: stack.push(shoppingListPage)
    }

    NavigationStack {
        id: stack

        // Initially, the login page is always visible when starting the app.
        LoginPage {
            id: loginPage

            // The login page contains a form to enter user name and password.
            // A checkbox lets the user choose whether to log in or to register a
            // new user. In both cases, this slot is called.
            onLogin: {
                if (isRegister) {
                    // Call the user registration method from our data model,
                    // which then forwards the request to Google Firebase
                    dataModel.registerUser(email, password)
                } else {
                    // Similar approach sending a user login request to Firebase.
                    dataModel.loginUser(email, password)
                }
            }
        }
    }

    // The main shopping list page, which will be pushed to the
    // navigation stack after the login process has been completed
    // successfully.
    Component {
        id: shoppingListPage
        MasterPage {
            // Slots of the master page
            // User added a new shopping item -> forward the request to the data model.
            onAddNewShoppingItem: dataModel.addShoppingItem(text)
            // User deleted a shopping item -> forward the request to the data model.
            onDeleteShoppingItem: dataModel.deleteShoppingItem(id)
            // User would like to see the details of the shopping item -> navigate to the detail page
            onShowShoppingItemDetails: stack.push(shoppingItemDetailsPage, {
                                                      "shoppingItem": shoppingItem
                                                  })
            // User navigated back in the UI - send logout request to Firebase
            onPopped: dataModel.logoutUser()
        }
    }

    // The shopping item detail page, which shows additional information
    // and allows changing the shopping item text.
    Component {
        id: shoppingItemDetailsPage

        DetailPage {
            // User changed details of the shopping item
            // -> forward the request to the data model to update it in the
            // Google Firebase Realtime Database
            onSaveShoppingItem: {
                dataModel.saveShoppingItem(shoppingItem)
                // After saving, navigate back to the shopping list page.
                stack.pop()
            }
        }
    }
}
