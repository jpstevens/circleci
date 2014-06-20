# CircleCI
[![Build Status](https://secure.travis-ci.org/jpstevens/circleci.png?branch=master)](https://travis-ci.org/jpstevens/circleci)
[![Dependencies](https://david-dm.org/jpstevens/circleci.png)](https://david-dm.org/jpstevens/circleci)

A CircleCI client for Node.js.

## Installation

To install, go to your console/terminal and run:

```bash
npm install circleci
```

## Usage

In your project, require the package:

```javascript
var circleci = require("circleci");
```

Then you can run one of the following methods:

### getUser()
API call: ``` GET /me ```

*Provides information about the signed in user.*

#### Example:
```javascript
circleci.getUser(function(err, user){
  if (err) {
    console.log(err);
  } else {
    console.log(user.username); // e.g. jpstevens
  }
});
```

### getRecentProjects()
API call: ``` GET /projects ```

*List of all the projects you're following on CircleCI, with build information organized by branch.*

#### Options:

- **limit** - The number of builds to return. Maximum 100, defaults to 30.
- **offset** - The API returns builds starting from this offset, defaults to 0.

#### Example:
```javascript
circleci.getProjects(function(err, projects){
  if (err) {
    console.log(err);
  } else {
    for (var i in projects) {
      console.log(projects[i].username + "/" + projects[i].reponame); // e.g. jpstevens/circleci
    }
  }
});
```

### getRecentProjects()
API call: ``` GET /projects ```

*List of all the projects you're following on CircleCI, with build information organized by branch.*

#### Example:
```javascript
circleci.getProjects(function(err, projects){
  if (err) {
    console.log(err);
  } else {
    for (var i in projects) {
      console.log(projects[i].username + "/" + projects[i].reponame); // e.g. jpstevens/circleci
    }
  }
});
```

TODO:

Documentation:
- Finish README

Testing:
- Add additional tests for API methods

Include methods to wrap:
- Adding a CircleCI key to your Github User account (POST: /user/ssh-key)
- Adding a Heroku API key to CircleCI, takes apikey as form param name (POST: /user/heroku-key)
- Retrying a build using SSH (POST: /project/:username/:project/:build_num/ssh)
