module.exports = {
    verbose: true,
    coverageDirectory: 'coverage',
    testEnvironment: 'node',
    bail: true,
    reporters: [
        'default',
        'jest-junit'
    ],
    testPathIgnorePatterns: [
        'integration.*'
    ]
};

