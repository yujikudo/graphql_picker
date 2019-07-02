# GraphqlPicker

It is hard to find GraphQL queries and mutations created in Apollo in .graphql files.  
There are many fragments used by Query and Mutation.  
Then, it is problematic to create a query when you execute in GraphiQL etc.  
GraphQL Picker can extract related fragments by specifying the query name of GrapqhQL.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphql_picker'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install graphql_picker

## Usage
You can search Query name `User` use option `-n`


    $ graphql_picker -n User 
    
Option `-p` is used to limit search directory


    $ graphql_picker -n User  -p graphqls_directory


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yujikudo/graphql_picker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GraphqlPicker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/graphql_picker/blob/master/CODE_OF_CONDUCT.md).
