## GCP IAM Report avoid_user-managed_service_account_keys Benchmark

Service account keys can become a security risk if not managed carefully. The main threats are related to service account keys are:

Credential leakage: Service account keys might inadvertently end up in places where they are not supposed to be stored. A bad actor can use a leaked service account key to authenticate and gain a foothold in your environment.
Privilege escalation: If a bad actor gets access to a poorly secured service account key, they might be able to use the key to escalate their privileges.
Information disclosure: Service account keys might inadvertently disclose confidential metadata.
Non-repudiation: By authenticating using a service account key and letting the service account carry out operations on their behalf, a bad actor might conceal their identity and actions.

The best way to mitigate these threats is to avoid user-managed service account keys and to use other methods to authenticate service accounts whenever possible. You can also use IAM conditions and VPC Service Controls to restrict what resources can potentially be accessed by a compromised service account.

References : https://cloud.google.com/iam/docs/best-practices-for-managing-service-account-keys

