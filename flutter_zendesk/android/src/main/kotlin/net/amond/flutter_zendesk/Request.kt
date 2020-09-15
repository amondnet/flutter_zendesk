package net.amond.flutter_zendesk

import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import zendesk.support.Comment
import zendesk.support.Request

@Serializable
data class RequestDTO(
    @SerialName("created_at")
    val createdAt: String,
    @SerialName("comment_count")
    val commentCount: Int? = 0,
    @SerialName("updated_at")
    val updatedAt: String,
    @SerialName("public_updated_at")
    val publicUpdatedAt: String,
    val id: String?,
    @SerialName("requester_id")
    val requesterId: Long?,
    val status: String?,
    @SerialName("collaborator_ids")
    val collaboratorIds: List<Long>,
    val subject: String?,
    val description: String?,
    @SerialName("last_comment")
    val lastComment: CommentDTO?
)
val requestSerializer: KSerializer<RequestDTO> = RequestDTO.serializer()

fun Request.toDTO(): RequestDTO {
  return RequestDTO(
      this.createdAt.toString(),
      this.commentCount,
      this.updatedAt.toString(),
      this.publicUpdatedAt.toString(),
      this.id,
      this.requesterId,
      this.status?.toString(),
      this.collaboratorIds,
      this.subject,
      this.description,
      this.lastComment?.toDTO()
  )
}


@Serializable
data class CommentDTO(
    val id: Long?
)
val commentSerializer: KSerializer<CommentDTO> = CommentDTO.serializer()

fun Comment.toDTO(): CommentDTO {
  return CommentDTO(this.id)
}