---

# yAPI Communication Module for Roblox

This module facilitates communication with yAPI in the Roblox platform.

## Usage

### Dependencies

This module depends on:
- `evaera_promise@4.0.0`

### Instructions

1. Import the module into your Roblox project.
2. Access various functionalities via the provided methods.

### Example

```lua
-- Example usage of the yAPI module

local yAPI = require(path.to.yAPI)

-- Access the methods
yAPI:Promise():fetchFromAPI("catalog/api/v2/search/items/details?Category=1&CreatorType=Group&CreatorTargetId=32397047", nil)
    :andThen(function(response)
        print("Data from API:", response)
    end)
    :catch(function(error)
        warn("Error fetching data:", error)
    end)

yAPI:Promise():getStatus()
    :andThen(function(response)
        print("Status from API:", response)
    end)
    :catch(function(error)
        warn("Error getting status:", error)
    end)
```

## License

This module is licensed under the MIT License. See [LICENSE](./LICENSE) for more details.

## Credits

- **@GramGramGaming123** - Developer
- **@rustyspotted** - Discord Contact
- **@zzen_a** - Twitter Contact

---