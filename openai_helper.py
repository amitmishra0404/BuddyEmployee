import openai
import json
from secret_key import openai_api_key
import db_helper

openai.api_key = openai_api_key


def get_answer(question):
    messages = [{'role': 'user', 'content': question}]
    functions = [
        {
            "name": "get_leavetypes",
            "description": """Get the different type of leave Policies details for a employees in infitiHacksDel (such Vacation, Sick Leave, Maternity/Paternity Leave,
            Personal Leave, Public Holiday, Bereavement Leave). 
            If function returns -1 then it means we could not find the record in a database for given input. 
            """,
            "parameters": {
                "type": "object",
                "properties": {
                    "leave_type": {
                        "type": "string",
                        "description": " if user provide leave type in infitiHacksDel show details of each leave type entered by users, or ask for correct input of leave type",
                        "enum": ["Vacation", "Sick Leave" , "Maternity/Paternity Leave", "Personal Leave", "Public Holiday", "Bereavement Leave"],
                    }
                },
                "required": ["leave_type"],
            }            
        },
        {
            "name": "get_policies",
            "description": """Get the different Policies details for a employees in infitiHacksDel (such work_policy, Ethic and Complaince, Finance). 
            If function returns -1 then it means we could not find the record in a database for given input. 
            """,
            "parameters": {
                "type": "object",
                "properties": {                    
                    "policies": {
                        "type": "string",
                        "description": "  users or infitihacks-del users has to enter type of policy for which they are looking for details",
                        "enum": ['WFM','time off policy','remote work policy','PTO','HOLIDAYS','ethics']
                    },                                    
                },
                "required": ["policies"],
            }

        }
        
        
    ]

    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo-0613",
        messages=messages,
        functions=functions,
        function_call="auto",  # auto is default, but we'll be explicit
    )
    response_message = response["choices"][0]["message"]

    if response_message.get("function_call"):
        available_functions = {
            "get_policies": db_helper.get_policies,
            "get_leavetypes": db_helper.get_leavetypes
        }
        function_name = response_message["function_call"]["name"]
        fuction_to_call = available_functions[function_name]
        #print(fuction_to_call)
        function_args = json.loads(response_message["function_call"]["arguments"])
        function_response = fuction_to_call(function_args)

        messages.append(response_message)
        messages.append(
            {
                "role": "function",
                "name": function_name,
                "content": str(function_response),
            }
        )
        second_response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-0613",
          # model="gpt-3.5-turbo-16k",
          messages=messages,
        )  # get a new response from GPT where it can see the function response
        return second_response["choices"][0]["message"]["content"]
    else:
        return response_message["content"]



if __name__ == '__main__':
    # print(get_answer("What was Peter Pandey's GPA in semester 1?"))
    # print(get_answer("average gpa in third semester?"))
    # print(get_answer("how much is peter pandey's pending fees in the first semester?"))
    print(get_answer("remote work policy"))
   #  print(get_answer("How do I request time off?"))
   # print(get_answer("What is the company policy on remote work?"))