/** @type {import('ts-jest').JestConfigWithTsJest} */
module.exports = {
    preset: 'ts-jest',
    testEnvironment: 'node',
    clearMocks: true,
    moduleFileExtensions: ['js', 'ts'],
    testMatch: ['**/*.spec.ts'],
    modulePathIgnorePatterns: ['<rootDir>/dist/'],
    testPathIgnorePatterns: ['/node_modules/', '/dist/'],
};
