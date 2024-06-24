package io.paioneer.nain.chat.jpa.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QChatRoomMemberId is a Querydsl query type for ChatRoomMemberId
 */
@Generated("com.querydsl.codegen.DefaultEmbeddableSerializer")
public class QChatRoomMemberId extends BeanPath<ChatRoomMemberId> {

    private static final long serialVersionUID = 2061907477L;

    public static final QChatRoomMemberId chatRoomMemberId = new QChatRoomMemberId("chatRoomMemberId");

    public final NumberPath<Long> chatRoomNo = createNumber("chatRoomNo", Long.class);

    public final NumberPath<Long> memberNo = createNumber("memberNo", Long.class);

    public QChatRoomMemberId(String variable) {
        super(ChatRoomMemberId.class, forVariable(variable));
    }

    public QChatRoomMemberId(Path<? extends ChatRoomMemberId> path) {
        super(path.getType(), path.getMetadata());
    }

    public QChatRoomMemberId(PathMetadata metadata) {
        super(ChatRoomMemberId.class, metadata);
    }

}

