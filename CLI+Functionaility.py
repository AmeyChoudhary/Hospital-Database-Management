import subprocess as sp
import pymysql
import pymysql.cursors


def InsertNewPatient():
    # Inserting a new patient with their details.
    # While inserting a new patient, only room number can be NULL
    try:
        print("Enter the following patient details: ")
        print(" ")

        row = {}
        row["PId"]=int(input("Enter the Patient ID: "))
        row["Aadhar_no"]= int(input("Enter the AADHAR  number of the patient: "))
        row["RoomNo"]= int(input("Enter the Patients Room Number: "))
        name =input("Name (First Name Last Name): ").split(' ')
        row["FName"]=name[0]
        row["Lname"]=name[1]
        row["DOB"]=input("Enter the Date of Birth in YYYY-MM-DD: ")
        row["Gender"]= input("Enter the Gender of Patient: ")

        query = "INSERT INTO Patients VALUES(%d, %d, %d,'%s',' %s', '%s', '%s')" %(row["PId"],row["Aadhar_no"], row["RoomNo"], row["FName"], row["Lname"], row["DOB"], row["Gender"])
        print(query)
        cur.execute(query)
        con.commit()

        print(" ")

        doctor_num= int(input("Enter the number of doctors who treated the patients: "))

        for i in range(doctor_num):
            row["DoctorID"]= int(input("Enter the ID of the Doctor treating the Patient: "))
            query = "INSERT INTO Treated_By VALUES(%d, %d)" %(row["PId"],row["DoctorID"])
            print(query)
            cur.execute(query)
            con.commit()
        
        print(" ")

        dept_num= int(input("Enter the number of departments the patient is under: "))

        for i in range(dept_num):
            row["DepartmentID"]= int(input("Enter the ID of the Department under which Patient is being treated: "))
            query = "INSERT INTO Patient_Is_Under_Department VALUES(%d, %d)" %(row["PId"],row["DepartmentID"])
            print(query)
            cur.execute(query)
            con.commit()

        print(" ")

        patient_ph_num= int(input("Enter the number of phone numbers the patient has (minimum 1): "))

        for i in range(patient_ph_num):
            Phone_num= int(input("Enter the phone number : "))
            query = "INSERT INTO Patient_PhoneNumber  VALUES(%d, '%s')" %(row["PId"],Phone_num)
            print(query)
            cur.execute(query)
            con.commit()
        
        print(" ")

        patient_disease= int(input("Enter the number of distinct diseases/illnesses the Patient is suffering from: "))

        for i in range(patient_disease):
            disease= input("Enter the diseases: ")
            query = "INSERT INTO Patient_Disease  VALUES(%d, '%s')" %(row["PId"],disease)
            print(query)
            cur.execute(query)
            con.commit()

        print(" ")

        yes_no= input(("If the patient has a past record, enter YES and fill the details: "))

        if yes_no=="YES":
            p_r_num=int(input("Number of past records: "))

            for i in range(p_r_num):
                opt_type= input("Enter the last operation type: ")
                opt_report= input("Enter the report of the last operation: ")
                doct_lastname= input("Enter the last name under which last doctor treated you: ")
                date=input("Enter the date of the last operation: ")
                query= "INSERT INTO Past_Record VALUES(%d, '%s', '%s', '%s','%s')" % (row["PId"], opt_type, opt_report,doct_lastname,date)
                print(query)
                cur.execute(query)
                con.commit()
        
        print(" ")

        print("Patient Details successfully Inserted Into Database")

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)

    return

def DeleteFormerDoctor():
    # deleting a former doctors data

    try:
        name =input("Enter the Name of Doctor to be Deleted (First Name Last Name): ").split(' ')
        query= "Select * From Doctor Where First_Name ='%s'AND Last_Name='%s';" % (name[0], name[1])
        cur.execute(query)
        con.commit()
        data =cur.fetchall()
        length=len(data)

        if length==0:
            print("No such doctor exists in database")
        elif length==1:
            for row in data:
                    doctor_id=row.get("DoctorID")
            query="Delete From Doctor Where DoctorID=%d;" %(doctor_id)
            cur.execute(query)
            con.commit()
            print("Doctor has been deleted from the Database")
        elif length>1:
            for row in data:
                print(row)
            doctor_id= int(input("There are various doctors with the same name. Kindly select the DoctorID of the required Doctor: "))
            query="Delete From Doctor Where DoctorID=%d;" %(doctor_id)
            cur.execute(query)
            con.commit()
            print("Doctor has been deleted from the Database")           


    except Exception as e:
        con.rollback()
        print("Failed to delete from database")
        print(">>>>>>>>>>>>>", e)

    return

def UpdateRoomAllot():

    try:
        room_number=int(input("Enter the Room Number: "))
        query="Select Distinct Department.Name From Department, Room_Is_Under_Department Where Room_Number=%d AND Room_Is_Under_Department.DepartmentID= Department.DepartmentID;" %(room_number)
        cur.execute(query)
        data=cur.fetchall()
        print("Old Department name was: ")
        for row in data:
            print(row)
        new_d_id=int(input("Enter the new department ID: "))
        query1="UPDATE Room_Is_Under_Department SET DepartmentID=%d Where Room_Number= %d;" % (new_d_id, room_number)
        cur.execute(query1)
        con.commit()

        query2="Select Distinct Department.Name From Department, Room_Is_Under_Department Where Room_Number=%d AND Room_Is_Under_Department.DepartmentID= Department.DepartmentID;" %(room_number)
        cur.execute(query2)
        data2=cur.fetchall()
        print("New Department name is: ")
        for row in data2:
            print(row)




    except Exception as e:
        con.rollback()
        print("Failed to update record in database")
        print(">>>>>>>>>>>>>", e)

    return

def SelectPatientDisease():

    try:
        disease =input("Enter the name of the disease: ")

        query= "Select Distinct First_Name,Last_Name From Patients, (Select PatientID From Patient_Disease Where Disease='%s') as Temp Where Patients.PatientID=Temp.PatientID;" %(disease)
        cur.execute(query)
        data=cur.fetchall()
        print(("Names of Patients having disease '%s' are: ")%(disease))
        for row in data:
            fname=row.get("First_Name")
            lname=row.get("Last_Name")
            print(("'%s':'%s'")%(fname,lname))
        con.commit()



    except Exception as e:
        con.rollback()
        print("Failed to select from database")
        print(">>>>>>>>>>>>>", e)

    return

def SelectDoctorDept():

    try:
        department =input("Enter the name of the department: ")

        query= "Select First_Name,Last_Name From Doctor, (Select Distinct DoctorID From Doctor_Is_Under_Department Where DepartmentID IN (Select DepartmentID From Department Where Name='%s')) as Temp Where Doctor.DoctorID=Temp.DoctorID;" %(department)
        cur.execute(query)
        data=cur.fetchall()
        print(("Names of Doctors working in '%s' are: ")%(department))
        for row in data:
            fname=row.get("First_Name")
            lname=row.get("Last_Name")
            print(("'%s':'%s'")%(fname,lname))
        con.commit()


    except Exception as e:
        con.rollback()
        print("Failed to select from database")
        print(">>>>>>>>>>>>>", e)

    return

def ProjectPatientAge():

    try:

        age=int(input("Enter the Age of Patients you want to find. Note that Age is calculated as of 1 Janyary,2022: "))
        year=str(2022-age)
        dob=year+'-01-01'

        query="Select First_Name, Last_Name, PatientID,Date_of_Birth From Patients Where Date_of_Birth <= '%s';" %(dob)
        cur.execute(query)
        data=cur.fetchall()

        if len(data)==0:
            print(("No one older than %d")%(age))
        else:
            print(("Names of Patients with age more than %d: ")%(age))
            for row in data:
                fname=row.get("First_Name")
                lname=row.get("Last_Name")
                pid=row.get("PatientID")
                dob1=row.get("Date_of_Birth")
                print(("'%s':'%s':'%s': %d")%(fname,lname,dob1,pid))
        con.commit()

    except Exception as e:
        con.rollback()
        print("Failed to project from database")
        print(">>>>>>>>>>>>>", e)

    return


def RoomCapacity():

    try:
        capacity=int(input("Enter the desired capacity: "))

        query="Select * From Rooms Where Capacity >= %d;" %(capacity)

        cur.execute(query)
        data=cur.fetchall()

        if len(data)==0:
            print(("There are no rooms with capacity greater than %d")%(capacity))
        else:
            print(("Rooms with atleast capacity of  %d: ")%(capacity))
            for row in data:
                print(row)
        con.commit()

    except Exception as e:
        con.rollback()
        print("Failed to project from database")
        print(">>>>>>>>>>>>>", e)

    return

def DoctorExp():

    try:
        # dept_name=input("Enter the name of the department: ")
        query="Select AVG(Practising_since) as Avg, Temp.Name as Dept From Doctor Join (Select Department.Name, Doctor_Is_Under_Department.DoctorID From Department Join Doctor_Is_Under_Department On Department.DepartmentID= Doctor_Is_Under_Department.DepartmentID) as Temp On Doctor.DoctorID= Temp.DoctorID Group By Temp.Name;"
        cur.execute(query)
        data=cur.fetchall()
        
        print("The average practising years of Doctors in the following Departments are: ")
        for row in data:
            avg=row.get("Avg")
            avg_int=int(avg)
            prs=2022-avg_int
            dept=row.get("Dept")
            print(("'%s' : %d ")%(dept, prs))
        con.commit()

    except Exception as e:
        con.rollback()
        print("Failed to aggregate from database")
        print(">>>>>>>>>>>>>", e)

    return


def RoomSearch():

    try:
        f=input("If you want to search by room number , enter 'R'. If you want to search by PatientID, enter 'P'.: ")

        if f=="R":
            r_no=int(input("Enter the room number: "))
            query="Select * From Patients Where Room_Number =%d;"%(r_no)
            cur.execute(query)
            data=cur.fetchall()
            if len(data)==0:
                print("Room is not occupied and is empty")
            else:
                for row in data:
                    print(row)
        elif f=="P":
            pid=int(input("Enter the PatientID: "))
            query="Select Room_Number From Patients Where PatientID=%d;"%(pid)
            cur.execute(query)
            data=cur.fetchall()
            if len(data)==0:
                print("There is no patient with such ID.")
            else:
                print("Room occupied by patient is: ")
                for row in data:
                    print(row)
        else:
            print("Input doesn't match the given format")
        con.commit()



    except Exception as e:
        con.rollback()
        print("Failed to search from database")
        print(">>>>>>>>>>>>>", e)

    return

def RoomAvail():

    try:
        query="Select Rooms.Room_Number From Rooms Left Join Patients On Patients.Room_Number= Rooms.Room_Number Where PatientID IS NULL;"
        cur.execute(query)
        data=cur.fetchall()
        if(len(data)==0):
            print("No rooms are empty")
        else:
            print("The following room numbers are empty")
            for row in data:
                print(row)
        con.commit()
        
    except Exception as e:
        con.rollback()
        print("Failed to search from database")
        print(">>>>>>>>>>>>>", e)

    return

def SucOpt():

    try:
        operation=input("Enter the name of the operation you want to find: ")

        query="Select * From Past_Record Where Operation_Type='%s';"%(operation)
        cur.execute(query)
        data=cur.fetchall()

        if len(data)==0:
            print("No such operation has been performed")
        else:
            query1="Select * From Past_Record Where Operation_Type='%s' AND Operation_Report='SUCCESSFUL';"%(operation)
            cur.execute(query1)
            data1=cur.fetchall()
            rate= len(data1)/len(data)
            print(("The total number of '%s' performed are %d")%(operation,len(data)))
            print(("The success probability of the operation is %f.")%(rate))


        con.commit()

    except Exception as e:
        con.rollback()
        print("Failed to analyse from database")
        print(">>>>>>>>>>>>>", e)

    return

def FreqDis():

    try:
        query="Select Date_of_Birth, Disease, Patients.PatientID from Patients Join Patient_Disease On Patients.PatientID= Patient_Disease.PatientID;"
        cur.execute(query)
        con.commit()
        data=cur.fetchall()

        query_view=" Create view SampleView as Select Date_of_Birth, Disease, Patients.PatientID from Patients Join Patient_Disease On Patients.PatientID= Patient_Disease.PatientID; "
        cur.execute(query_view)
        con.commit()



        for row in data:
            pid=row.get("PatientID")
            date=str(row.get("Date_of_Birth"))
            if date>='2012-01-01':
                mdf=1 #1-10
                mdfd='2012-01-01'
            elif date>='2002-01-01':
                mdf=2 #11-20
                mdfd='2002-01-01'
            elif date>='1992-01-01':
                mdf=3#21-30
                mdfd='1992-01-01'
            elif date>='1982-01-01':
                mdf=4#31-40
                mdfd='1982-01-01'
            elif date>= '1972-01-01':
                mdf=5#41-50
                mdfd='1972-01-01'
            elif date>= '1962-01-01':
                mdf=6#51-60
                mdfd='1962-01-01'
            elif date>= '1952-01-01':
                mdf=7#61-70
                mdfd='1952-01-01'
            elif date>='1942-01-01':
                mdf=8#71-80
                mdfd='1942-01-01'
            query_update="Update SampleView SET Date_of_Birth='%s' Where PatientID=%d"%(mdfd,pid)
            cur.execute(query_update)
            con.commit()

        query_2="Select Date_of_Birth, MAX(Disease) as Most_Frequent_Disease From SampleView Group By Date_of_Birth Order By Date_of_Birth DESC;"
        cur.execute(query_2)
        con.commit()

        data1=cur.fetchall()
        for row in data1:
            dob=str(row.get("Date_of_Birth"))
            dob1=dob.split("-")    
            year=int(dob1[0])
            u_limit=2022-year
            l_limit=u_limit-9
            fd=str(row.get("Most_Frequent_Disease"))
            print(("The most frequent disease in age group %d-%d: '%s'")%(l_limit,u_limit,fd))


            
            


                      




        #remember to delete view also
        query_Del="Drop View SampleView;"
        cur.execute(query_Del)
        con.commit()


    except Exception as e:
        con.rollback()
        print("Failed to analyse from database")
        print(">>>>>>>>>>>>>", e)

    return






def dispatch(ch):
    """
    Function that maps helper functions to option entered
    """

    if(ch == 1):
        InsertNewPatient()
    elif(ch == 2):
        DeleteFormerDoctor()
    elif(ch == 3):
        UpdateRoomAllot()
    elif(ch == 4):
        SelectPatientDisease()
    elif(ch == 5):
        SelectDoctorDept()
    elif(ch == 6):
        ProjectPatientAge()
    elif(ch == 7):
        RoomCapacity()
    elif(ch == 8):
        DoctorExp()
    elif(ch == 9):
        RoomSearch()
    elif(ch == 10):
        RoomAvail()
    elif(ch == 11):
        SucOpt()
    elif(ch == 12):
        FreqDis()
    else:
        print("Error: Invalid Option")

# main code to implement CLI
# Global
# DO NOT CHANGE this!!! Only change the user and password if required
while(1):
    tmp = sp.call('clear', shell=True)
    
    # Can be skipped if you want to hardcode username and password
    username = input("Username: ")
    password = input("Password: ")

    try:
        # Set db name accordingly which have been create by you
        # Set host to the server's address if you don't want to use local SQL server 
        con = pymysql.connect(host='localhost',
                              port=3306,
                              user=username, #username must be dna_root
                              password=password, #password must be dnaRoot*123
                              db='Proj_4',
                              cursorclass=pymysql.cursors.DictCursor)
        tmp = sp.call('clear', shell=True)

        if(con.open):
            print("Connected")
        else:
            print("Failed to connect")

        tmp = input("Enter any key to CONTINUE>")

        with con.cursor() as cur:
            while(1):
                tmp = sp.call('clear', shell=True)
                print("1. Insert a New Patient")  # Insert a New Patient Details
                print("2. Deleting a Former Doctor")  # Deleting a former Doctor
                print("3. Updating the Room Allotment to Department")  # Updating the Past Record
                print("4. Select Patients Having a Particular Disease")  # Patients with a particular disease
                print("5. Select Doctors in a certain Department")
                print("6. Patients Older than a Certian Age")
                print("7. Room with capacity")
                print("8. Avergae Experience Level of Doctors in Department")
                print("9. Room Search")
                print("10. Room Availability")
                print("11. Success Rate of Any Operation")
                print("12. Most Frequent Disease in Age Group")
                print("13. Logout") # Logout of the SQL
                ch = int(input("Enter choice> "))
                tmp = sp.call('clear', shell=True)
                if ch == 13:
                    exit()
                else:
                    dispatch(ch)
                    tmp = input("Enter any key to CONTINUE>")

    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print(e)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
        tmp = input("Enter any key to CONTINUE>")

# Code finishes here