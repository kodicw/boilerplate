# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

If you find a security vulnerability, please report it privately rather than opening a public issue.

### Scope

- Insecure defaults or privilege escalation paths.
- Exposed secrets or insecure secret handling patterns.
- Vulnerabilities in configuration or infrastructure-as-code.

### Reporting Process

1. **Email**: Send a detailed report to the maintainers.
2. **Details**: Include a description of the vulnerability, steps to reproduce, and potential impact.
3. **Acknowledgement**: You will receive an acknowledgement within 48 hours.
4. **Fix**: We will work on a fix and coordinate a disclosure date with you.

Please do not disclose the vulnerability publicly until a fix has been released.

## Security Principles

- **Least Privilege**: Services and processes run with minimum necessary permissions.
- **Reproducibility**: All configurations are reproducible for auditability.
- **No Hardcoded Secrets**: Use environment variables, secret stores, or encrypted inputs.
