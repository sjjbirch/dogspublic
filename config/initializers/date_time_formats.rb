# an initialiser to make dates not seppo

# amazingly all three of these are needed despite seeming redundant

Date::DATE_FORMATS[:default] = '%d/%m/%Y'

# if you want to change the format of Time display then add the line below
Time::DATE_FORMATS[:default]= '%d/%m/%Y %H:%M:%S'

# if you want to change the DB date format.
Time::DATE_FORMATS[:db]= '%d/%m/%Y %H:%M:%S'