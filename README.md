# AI_cordinator
AI Cordinator using AI(Clarifai) for Capston Design Contest

## 한양대학교 에리카 캠퍼스 캡스톤 디자인     
#### 인공지능을 사용한 스마트 옷장    
                  
<hr/>
                     
+ 옷장에 설치된 카메라를 이용하여 사용자가 옷을 촬영한다.       
+ 저장된 옷사진을 Clarifai API를 이용하여 정보를 추출하고 그 정보를 이용하여 사용자에게 맞는 옷을 추천한다.     

* 작동 순서: pi_camera -> AWS_S3(save) -> lamba -> ec2 -> rdms -> web     
                   
### Server(kdpark)   
Tech : AWS(lambda, IOT, ec2, rdms, S3), Nginx, Flask    
OS: Linux Ubuntu        
Language : C, Python           
             
### Hardware(kdpark)              
Tech : NFC(using scard), raspberry_pi                  
OS: rasbian                 
Language : C, python                  
                  
### Cloth detect(kdpark)                 
: Claifai API 사용                            

### Hardware(Tuna_HG)
Tech : pi_camera, raspberry_pi
OS : rasbian\n
Language : python


