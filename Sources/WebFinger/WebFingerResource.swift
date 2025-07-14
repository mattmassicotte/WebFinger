public enum WebFingerResource {
	public static let contentType = "application/jrd+json"
}

extension WebFingerResource {
	public struct Descriptor: Codable, Hashable, Sendable {
		public let subject: String
		public let aliases: [String]?
		public let properties: [String: String]?
		public let links: [Link]?

		public init(subject: String, aliases: [String]?, properties: [String : String]? = nil, links: [Link]?) {
			self.subject = subject
			self.aliases = aliases
			self.properties = properties
			self.links = links
		}
	}
}

extension WebFingerResource.Descriptor {
	public struct Link: Codable, Hashable, Sendable {
		public let rel: String
		public let type: String?
		public let href: String?
		public let properties: [String: String]?
		public let titles: Titles?

		public init(rel: String, type: String?, href: String?, properties: [String : String]? = nil, titles: Titles? = nil) {
			self.rel = rel
			self.type = type
			self.href = href
			self.properties = properties
			self.titles = titles
		}
	}
}

extension WebFingerResource.Descriptor {
	public enum Titles: Codable, Hashable, Sendable {
		case undefined
		case pairs([String: String])
	}
}

extension WebFingerResource {
	public struct Query: Codable, Hashable, Sendable {
		public static let path = "/.well-known/webfinger"

		public let user: String
		public let server: String
		public let rel: [String]

		public init(user: String, server: String, rel: [String] = []) {
			self.user = user
			self.server = server
			self.rel = rel
		}

		public var resource: String {
			"acct:\(account)"
		}

		public var account: String {
			"\(user)@\(server)"
		}
	}
}

extension WebFingerResource.Query {
	public init?(resource: String, rel: [String] = []) {
		guard resource.hasPrefix("acct:") else {
			return nil
		}

		let components = resource
			.suffix(resource.count - 5)
			.split(separator: "@")

		guard components.count == 2 else {
			return nil
		}

		self.user = String(components[0])
		self.server = String(components[1])
		self.rel = rel
	}
}
