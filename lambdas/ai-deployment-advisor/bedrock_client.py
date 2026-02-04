import  os
import json
import  boto3

bedrock =  boto3.client("bedrock-runtime",  region_name=os.environ.get("AWS_REGION",  "us-east-1"))

def  get_deployment_decision(context:  dict)  ->  dict:
       from pathlib  import  Path

       prompt_template  = Path(__file__).parent  /  "prompt_templates"  /  "deployment_strategy.txt"
       template =  prompt_template.read_text()

       prompt  =  template +  "\n\nDeployment  context  JSON:\n"  + json.dumps(context,  indent=2)

       body  =  {
              "prompt":  prompt,
              "max_tokens":  512,
              "temperature":  0.2,
       }

       response  =  bedrock.invoke_model(
              modelId="anthropic.claude-3-sonnet-20240229-v1:0",
              body=json.dumps(body),
               contentType="application/json",
              accept="application/json",
       )

       payload =  json.loads(response["body"].read())
       text  =  payload.get("completion")  or payload.get("output_text")  or  ""

       #  Extract JSON  block
       try:
              start  =  text.index("{")
              end  =  text.rindex("}")  + 1
               return json.loads(text[start:end])
       except  Exception:
              return  {
                      "strategy": "block",
                      "risk_score":  100,
                     "notes":  "Failed  to parse  AI  response;  blocking  deployment."
              }
