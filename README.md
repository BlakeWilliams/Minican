# Minican

Minican is a tiny authorization library that takes ideas from [Cancan](https://github.com/ryanb/cancan)
and [Pundit](https://github.com/elabs/pundit). It was extracted from Headquarters after attempting to write
authorization from scratch.

## Installation

Just add Minican to your gemfile and you're good to go.

```ruby
gem 'minican'
```

## Usage

### Define a policy
A policy is a class in the `app/policies` directory that inherits from Minican::Policy. This gives the object an initializer
that takes the object the policy will authorize. You can access the object in your class by `object` or the instance variable named after
the policy class. 

eg: You have a `GuestUser`. You could access the instance of `GuestUser` by `object` or `@guest_user`.

If you are authorizing a `Profile` model your policy might look like this:

```ruby
class ProfilePolicy < Minican::Policy
  def update?(user)
    @profile.user == user
  end
end
```

Minican assumes the following about your policy classes:

* The class inherits from `Minican::Policy`
* The class is named after the class to test with "Policy" appended.
* All methods that test authorization must be predicate methods
* All methods that are called with `can?` accept a user argument

### Using Policies
Minican provides the `authorize!` method for controllers.

```ruby
def update
  @profile = Profile.find(params[:id])
  authorize! :update, @profile
end
```

This calls the `update?` method on the `ProfilePolicy` using the profile we just found. There is an optional 
third argument which is the user that is passed to the policy method. The default is value for it is `current_user`.

If the `authorize!` call fails it will raise `Minican::AccessDenied`. You can rescue this in your controller.

```ruby
rescue_from Minican::AccessDenied do |exception|
  redirect_to root_url, alert: 'You do not have permission to access that resource'
end
```

Minican also provides `can?` and `cannot?` helpers that are accessible in controllers and views. They take the same arguments as `authorize!`


```erb
<% if can? :update, @profile %>
  <%= link_to 'Edit Profile', edit_profile_path(@profile) %>
<% end %>
```

### Using classes instead of instances
Minican was designed for this use case and checks if the object passed to your policy is an object or an instance. If it's a class it uses the same policy class as if you passed it an instance. That means you
can do things like `authorize! :can_create, Profile` where `@profile` in your policy would be your `Profile` class.

```ruby
class ProfilePolicy < Minican::Policy
  def can_create?(user)
    user.profile.nil?
  end
end
```

### Using policies inside of policies
Sometimes you need to call one policy from inside of another. Minican makes that simple with the `policy_for` method. `policy_for` takes an object and returns a new instance of the policy for that class.

Imagine we have a blog post where users can only comment if they have read access to the post.

```ruby
class CommentPolicy < Minican::Policy
  def can_create?(user)
    policy = policy_for(@comment.post)
    policy.can? :read, user
  end
end
```

## Questions?
If you have questions or think some clarification should be added to the readme feel free to open a [Github Issue](https://github.com/BlakeWilliams/Minican/issues).

## TODO
* Add generator for policy classes
* Add support for arrays with a controller method
* Add a filter helper method to remove unauthorized objects from arrays

## Contributing
If you have a feature request or a bug, please file an issue on Github or provide a pull request.

1. Clone the Repo
2. Create a topic branch
3. Run the tests with `rake spec`
4. Add your feature and the appropriate tests
5. Make sure all tests are passing
6. Commit your changes and make a pull request
