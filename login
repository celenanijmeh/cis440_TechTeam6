## basic login - first sprint feb 4 2024

import os
import random

accounts = {'nsansouci': {'Pin': 9999, 'Name': 'Nick San Souci'}, 
            'cnijmeh': {'Pin': 1234, 'Name': 'Celena Nijmeh'},
            'dbednar': {'Pin': 5678, 'Name': 'Dominik Bednar'}}
selection = ''
# end of todo
pin = 0
ans = ''

# Allow 3 invalid pin entries
tries = 1
pin_tries = 1
max_tries = 3
pin_found = False

username = input('Welcome to Cactus Bank.  Please enter your username: ')

if username not in accounts:
    print(f"{username}, Didn't find your username.")
    ans = input("Do you want to create an account (Y/N)? ").lower()
    if ans[0] != 'y':
        print('Thank you for visiting Cactus Bank.  Come back soon.')
        tries = max_tries + 1
    else:
        ans1 = int(input('Enter 1 to create a pin yourself or 2 and the system will create a pin for you: '))
        if ans1 == 1:
            while pin_tries <= max_tries:
                pin = int(input('Select a number between 1 and 9999 as your pin: '))
                print(pin)
                if 0 < pin < 10000:
                    accounts[username] = pin
                    pin_found = True
                    pin_tries = max_tries + 1
                else:
                    print('Invalid pin entered.')
                    pin_tries += 1
                    if pin_tries > max_tries:
                        print('Please try later ....')
                        tries = max_tries + 1
        elif ans1 == 2:
            pin = random.randint(1, 9999)
            print("Your pin is: ", pin)
            accounts[username] = pin
            tries = 1
            pin_found = True
        else:
            print('Invalid option! Thank you for visiting Cactus Bank.  Come back soon.')
            tries = max_tries + 1

    if pin_found:
        print("Please remember your pin.")
        print("The system will require you to enter it again.")
        input("Press Enter to continue...")
        # os.system('cls') for windows
        os.system('clear')

while tries <= max_tries:
    # Print bank title and menu
    print(f'{"Cactus Bank":^30}\n')
    selection = input('Enter pin or x to exit application: ').casefold()

    # determine exit, pin not found, or correct pin found
    if selection == 'x':
        break
    # FIXME: Verify entered pin is the same as the pin stored in the accounts dictionary
    elif int(selection) != accounts[username]['Pin']:
    # end of FIXME
        # clear screen - cls for windows and clear for linux or os x
        os.system('cls')
        # os.system('clear')

        print(f'Invalid pin. Attempt {tries} of {max_tries}. Please Try again')
        if tries == max_tries:
            print('Locked out!  Exiting program')
        # increment tries
        tries += 1
    else:
        # Upgrade: successful pin entry. reset tries and save pin
        tries = 1
        pin = selection

        # clear screen
        os.system('clear')

        # TODO: Welcome customer
        # Display Welcome <Customer Name>
        # accounts[username]['Name'] holds a dictionary where 'Name' is the key
        # to the customer's name value
        print(f"Welcome {accounts[username]['Name']}")
        # end of todo

        # TODO: Add prompt for Checking or Savings
        # Entry must be C or S to use as a key for the account balances
        # Use a loop and exception handling to ensure input is good
        # reuse selection name to store input to avoid scope issues
        while True:
            selection = input('\nSelect Account\n\tEnter C for Checking or S for Savings : ').upper()
            try:
                if selection != 'C' and selection != 'S':
                    raise ValueError('Incorrect selection. You must enter C or S')
            except ValueError as error_info:
                print(error_info)
            else:
                os.system('clear')
                print(f'Opening {selection} Account ...\n')
                break
        # end of todo

        # Upgrade: Removed slicing and w/d entry - New Instructions
        print('Transaction instructions:')
        print(' - Withdrawal enter a negative dollar amount: -20.00.')
        print(' - Deposit enter a positive dollar amount: 10.50')

        # Upgrade: removed for loop only 1 transaction per pin input

        # FIXME: All references to account need to be fixed
        # accounts is the new dictionary that needs to be indexed
        # using the entered username and the selection account type
        print(f'\nBalance:  ${accounts[username][selection]: .2f}')
        # end of fixme

        # TODO: Add exception handling for user entry of amount
        # Good input - convert to float and store in amount
        # Exception - Print Bad Amount and set amount to zero
        amount = float()
        try:
            amount = float(input(f'Enter transaction amount: ').casefold())
        except Exception:
            print('Bad Amount - No Transaction')
            amount = 0.0
        # end of todo

        # Upgrade: Verify enough funds in account
        # FIXME: All references to account need to be fixed
        # add indices for pin and selection holding account type
        if (amount + accounts[username][selection]) >= 0:
            accounts[username][selection] += amount
            print(f'Transaction complete. New balance is {accounts[username][selection]: .2f}')
            # end of fixme
        else:
            print('Insufficient Funds. Transaction Cancelled.')
