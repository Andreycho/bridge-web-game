class Call < ApplicationRecord
    enum call: { pass: 0, double: 1, redouble: 2 }
end
