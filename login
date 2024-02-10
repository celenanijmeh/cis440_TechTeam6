## basic login - first sprint feb 4 2024

import os
import random

accounts = {'nsansouci': {'Pin': 9999, 'Name': 'Nick San Souci'}, 
            'cnijmeh': {'Pin': 1234, 'Name': 'Celena Nijmeh'},
            'dbednarz': {'Pin': 5678, 'Name': 'Dominik Bednarz'},
            'drubioruiz': {'Pin': 1928, 'Name': 'Daniel Rubio Ruiz'}}
selection = ''
pin = 0
ans = ''

# Allow 3 invalid pin entries
tries = 1
pin_tries = 1
max_tries = 3
pin_found = False

# inital prompt
username = input('Welcome to SurveyBank.  Please enter your username: ')

# no account?
if username not in accounts:
    print(f"{username}, Didn't find your username.")
    ans = input("Do you want to create an account (Y/N)? ").lower()
    # exit, don't make account
    if ans[0] != 'y':
        print('Thank you for visiting SurveyBank.  Come back soon.')
        tries = max_tries + 1
    # make account
    else:
        ans1 = int(input('Enter 1 to create a pin yourself or 2 and the system will create a pin for you: '))
        # make your own pin, with validation
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
        # random pin
        elif ans1 == 2:
            pin = random.randint(1, 9999)
            print("Your pin is: ", pin)
            accounts[username] = pin
            tries = 1
            pin_found = True
        # fallback for bad input
        else:
            print('Invalid option! Thank you for visiting SurveyBank.  Come back soon.')
            tries = max_tries + 1

    # remind new account of pin
    if pin_found:
        print("Please remember your pin.")
        print("The system will require you to enter it again.")
        input("Press Enter to continue...")
        os.system('clear')

# since username found -> ask for pin
while tries <= max_tries:
    # Print bank title and menu
    print(f'{"SurverBank":^30}\n')
    selection = input('Enter pin or x to exit application: ').casefold()

    # determine exit, pin not found, or correct pin found
    if selection == 'x':
        break
    elif int(selection) != accounts[username]['Pin']:
        os.system('clear')
        print(f'Invalid pin. Attempt {tries} of {max_tries}. Please Try again')
        if tries == max_tries:
            print('Locked out!  Exiting program')
        # increment tries
        tries += 1
    else:
        tries = 1
        pin = selection
        os.system('clear')
        # welcome account user
        print(f"Welcome {accounts[username]['Name']}")
        exit()
        
