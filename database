## database - sprint 2 feb 11 2024

## Celena

import json
import os

survery_data = {}
# TODO: once we have survey, import new survey into dict^

# create json if not already
if not path.isfile('survey.json'):
    file = open('survey.json', 'w')
    file.write('SurveyBank Survey Records: \n')
    # TODO: Add the data titles we want to save
    file.write('[***Enter Data Points To Save*** \n')
    file.close()

# confirm data to save
print(survey_data)
confirm = input('/nSave? (y/n) :').lower()

# confirm to save
if confirm == 'y':
    # add data to json
    with open('survey.json', 'a', newline='') as fp:
        fp.write(f'{survey_data}\n')
    print('Saved!')
# deny to exit
else:
    # exit no save
    print('Okay. We no save. Goodbye ...')
exit()
