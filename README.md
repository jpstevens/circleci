# circleci
[![Build Status](https://secure.travis-ci.org/jpstevens/circleci.png?branch=master)](https://travis-ci.org/jpstevens/circleci)

A CircleCI client for Node.js.

## Installation:

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
ci.getUser(function(err, user){
  if (err) {
    console.log(err);
  } else {
    console.log(user.username); // e.g. jpstevens
  }
});
```

### getProject()
API call: ``` GET /projects ```
*List of all the projects you're following on CircleCI, with build information organized by branch.*

#### Example:
```javascript
ci.getProjects(function(err, projects){
  if (err) {
    console.log(err);
  } else {
    for (var i in projects) {
      console.log(projects[i].username + "/" + projects[i].reponame); // e.g. jpstevens/circleci
    }
  }
});
```
