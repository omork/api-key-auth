api-key-auth
============

This gem allows you to provide per-request authentication without requiring a username and password every time by issuing API keys which are not directly persisted to disk. The only thing stored is a hash of the value against an application secret. The holder of the API key is responsible for maintaining its secrecy.

The purpose of this is to allow single challenge authentication without *possibly* leaking the stored key. Your application will only know the value of the API key when it's generated but doesn't have to persist it to authenticate each request.

example
=======
The below example shows how to use api-key-auth in your controller:

    class UserController < ApplicationController
      before_filter :api_key_required, :only => :show
    
      def show
        @user = owner_of_api_key
      end
    end
