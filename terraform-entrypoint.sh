#!/bin/bash
rails db:create db:migrate

rails assets:precompile

rails s -b 0.0.0.0 -p 80
