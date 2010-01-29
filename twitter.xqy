xquery version "1.0-ml";

(:
 : Generic Twitter Functions Library
 :
 : Copyright (c) 2010 Nuno Job [about.nunojob.com]. All Rights Reserved.
 :
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 : http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :
 : The use of the Apache License does not indicate that this project is
 : affiliated with the Apache Software Foundation.
 :)

module namespace twitter = "http://ns.dscape.org/2010/twitter";

import module namespace http = "http://ns.dscape.org/2010/http" at "http.xqy";

declare function twitter:get-friends-timeline($username, $password) {
  http:get( "http://twitter.com/statuses/friends_timeline.xml",
    http:options-for-basic-auth($username, $password)) };

declare function twitter:auth-successful($username, $password) {
	http:valid-http-status( twitter:get-friends-timeline($username,$password) ) };

declare function twitter:delete_status($username, $password, $id) {
  let $options  := http:options-for-basic-auth($username, $password)
  let $delete   := http:delete( 
    fn:concat("http://twitter.com/statuses/destroy/",$id,".xml"), $options)
  return http:valid-http-status($delete) };

declare function twitter:tweet($username, $password, $message) {
    let $options := http:options-for-basic-auth($username, $password)
    let $post    := http:post( 
      fn:concat("http://twitter.com/statuses/update.xml?status=", 
             xdmp:url-encode($message) ), $options)
    return http:valid-http-status($post) };
