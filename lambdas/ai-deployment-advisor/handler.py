import  json
from  bedrock_client  import get_deployment_decision

def  lambda_handler(event,  context):
       """
       Expected event  from  GitHub  Action:
       {
          "diff_summary":  "...",
           "test_results":  {...},
          "service_risk_profile":  {...},
           "deployment_history": {...}
       }
       """
       try:
               body =  event  if  isinstance(event,  dict) else  json.loads(event.get("body",  "{}"))
       except  Exception:
              body  =  {}

       decision  =  get_deployment_decision(body)

       return  {
              "statusCode":  200,
              "body":  json.dumps(decision)
       }
