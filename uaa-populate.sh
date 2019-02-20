#!/bin/bash

type uaac &> /dev/null || {
  echo "uaac must be installed first!"
  return 1
}

echo "Targeting local UAA ..."
uaac target http://localhost:8080/uaa --skip-ssl-validation

echo -e "\nLogin as a canned client ..."
uaac token client get admin -s adminsecret

echo -e "\nAdding a client credential with client_id of client1 and client_secret of client1 ..."
uaac client add client1 \
   --name client1 \
   --scope resource.read,resource.write,openid,profile,email,address,phone \
   -s client1 \
   --authorized_grant_types authorization_code,refresh_token,client_credentials,password \
   --authorities uaa.resource \
   --redirect_uri http://localhost:8888/**

echo -e "\nAdding another client credential resource1/resource1 ..."
uaac client add resource1 \
  --name resource1 \
  -s resource1 \
  --authorized_grant_types client_credentials \
  --authorities uaa.resource

echo -e "\nAdding a user called user1/user1 ..."
uaac user add user1 -p user1 --emails user1@user1.com
uaac user add user2 -p user2 --emails user2@user2.com

echo -e "\nAdding two scopes: resource.read, resource.write ..."
uaac group add resource.read
uaac group add resource.write

echo -e "\nAssigning user1 both resource.read, resource.write scopes"
uaac member add resource.read user1
uaac member add resource.write user1

echo -e "\nAssign user2 only resource.read scope"
uaac member add resource.read user2
