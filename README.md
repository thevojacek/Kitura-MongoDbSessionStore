# Kitura-MongoDbSessionStore

A store for Kitura session in MongoDB using MongoKitten driver.

## Requirements
This session store accepts only MongoKitten collection as DI to work with right now, so you need to be using 
MongoKitten driver in order to be able to use package.

Support for official MongoDB driver will be coming as well.

## Example usage

```swift
import Foundation
import Kitura
import KituraSession
import Kitura_MongoDbSessionStore

// Connect to MongoDB
let server = try Server("mongo_url")
let database = server["database_name"]
let collection = database["collection_name"]

// Kitura router
let router = Router()

// Store initialization
let store = KituraMongoDbSessionStore(collection)

// Store usage
router.all(middleware: Session(secret: "super_secret", cookie: nil, store: store))
```

## License
Copyright 2018 Jan Vojáček

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Full license text is available in LICENSE.txt attached to this library.
